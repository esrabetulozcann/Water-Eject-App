import 'package:flutter/material.dart';
import 'core/initialization/app_initializer.dart';
import 'app/app.dart';

//import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  final onboardingCompleted = await AppInitializer.initialize();

  runApp(WaterEjectApp(onboardingCompleted: onboardingCompleted));
}
