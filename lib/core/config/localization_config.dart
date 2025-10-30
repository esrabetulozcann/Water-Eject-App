import 'package:flutter/widgets.dart';

//çok dillilik (multi-language) sisteminin ayarlarını merkezi bir yerde topladım
class LocalizationConfig {
  static const List<Locale> supportedLocales = [
    Locale('tr', 'TR'),
    Locale('en', 'US'),
  ];

  static const Locale fallbackLocale = Locale('tr', 'TR');
  static const String translationsPath = 'assets/translations';
}
