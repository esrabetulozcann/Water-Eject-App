import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  const ThemeState(this.mode);
  @override
  List<Object?> get props => [mode];
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.system));

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('themeMode') ?? 'system';
    emit(ThemeState(_fromString(value)));
  }

  Future<void> toggle(bool dark) async {
    final mode = dark ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(mode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _toString(mode));
  }

  String _toString(ThemeMode m) => switch (m) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };

  ThemeMode _fromString(String s) => switch (s) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
