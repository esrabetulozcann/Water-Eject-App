import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_eject/core/config/app_config.dart';
import 'package:water_eject/core/di/locator.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeDependencies();
    await _setDeviceOrientation();
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
}
