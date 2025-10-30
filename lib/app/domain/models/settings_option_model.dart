import 'package:flutter/material.dart';

class SettingsOption<T> {
  final T value;
  final String label;
  final IconData? icon;

  const SettingsOption({required this.value, required this.label, this.icon});
}
