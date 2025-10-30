import 'package:flutter/services.dart';
import 'package:water_eject/app/common/router/app_router.dart';

class AppConfig {
  static const String appTitle = 'Water Eject';
  static const bool debugBanner = false;

  static const List<DeviceOrientation> preferredOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const String initialRoute = AppRouter.onboarding;
}
