import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_eject/core/config/app_config.dart';
import 'package:water_eject/core/di/locator.dart';

//AppInitializer, uygulama başlamadan önce gerekli bağımlılıkları, ekran yönünü ve localization sistemini başlatıyor
class AppInitializer {
  static bool isOnboardingCompleted = false;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeDependencies();
    await _setDeviceOrientation();
    await _checkOnboardingStatus();
  }

  static Future<void> _initializeDependencies() async {
    await EasyLocalization.ensureInitialized();
    setupLocator();
  }

  static Future<void> _setDeviceOrientation() async {
    await SystemChrome.setPreferredOrientations(
      AppConfig.preferredOrientations,
    );
  }

  static Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isOnboardingCompleted = prefs.getBool('onboarding_completed') ?? false;
  }
}
