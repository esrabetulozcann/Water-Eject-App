import 'package:flutter/material.dart';
import 'core/initialization/app_initializer.dart';
import 'app/app.dart';

Future<void> main() async {
  await AppInitializer.initialize();

  runApp(const WaterEjectApp());
}
