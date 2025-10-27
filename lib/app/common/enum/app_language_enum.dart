import 'package:flutter/material.dart';

enum AppLanguage { system, en, tr }

extension AppLanguageX on AppLanguage {
  Locale? get locale {
    switch (this) {
      case AppLanguage.system:
        return null; // cihaz dili
      case AppLanguage.en:
        return const Locale('en', 'US');
      case AppLanguage.tr:
        return const Locale('tr', 'TR');
    }
  }

  String get label {
    switch (this) {
      case AppLanguage.system:
        return 'System';
      case AppLanguage.en:
        return 'English';
      case AppLanguage.tr:
        return 'Türkçe';
    }
  }
}
