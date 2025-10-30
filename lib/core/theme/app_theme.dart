import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/colors.dart';

//AppTheme, uygulamanın renk paletini, aydınlık/karanlık mod yapılarını ve Material ayarlarını merkezi bir yerde yönetmek için yazıldı
class AppTheme {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
