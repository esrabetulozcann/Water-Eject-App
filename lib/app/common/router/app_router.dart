import 'package:flutter/material.dart';
import 'package:water_eject/app/features/presentation/onboarding/views/onboarding_view.dart';
import 'package:water_eject/app/features/presentation/cleaner/views/cleaner_shell.dart';
import 'package:water_eject/app/features/presentation/stereo/views/stereo_view.dart';

class AppRouter {
  static const String onboarding = '/';
  static const String cleaner = '/cleaner';
  static const String stereo = '/stereo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case cleaner:
        return MaterialPageRoute(builder: (_) => const CleanerShell());
      case stereo:
        return MaterialPageRoute(builder: (_) => const StereoView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Sayfa bulunamadı: ${settings.name}')),
          ),
        );
    }
  }

  static void push(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  static void pushReplacement(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
