import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_eject/core/config/app_config.dart';
import 'package:water_eject/core/di/locator.dart';

//AppInitializer, uygulama başlamadan önce gerekli bağımlılıkları, ekran yönünü ve localization sistemini başlatıyor
class AppInitializer {
  static Future<bool> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    await _setDeviceOrientation();
    await _initServices();

    return _checkOnboardingStatus();
  }

  static Future<void> _initServices() async {
    setupLocator();
    await MobileAds.instance.initialize();
  }

  static Future<void> _setDeviceOrientation() async {
    await SystemChrome.setPreferredOrientations(
      AppConfig.preferredOrientations,
    );
  }

  static Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }
}
