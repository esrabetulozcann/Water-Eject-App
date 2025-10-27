import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final bool isDarkMode;
  final bool isEnglish;

  const SettingState({this.isDarkMode = false, this.isEnglish = true});

  SettingState copyWith({bool? isDarkMode, bool? isEnglish}) {
    return SettingState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isEnglish: isEnglish ?? this.isEnglish,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, isEnglish];
}
