import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/router/app_router.dart';
import 'package:water_eject/core/config/app_config.dart';
//import 'package:water_eject/core/initialization/app_initializer.dart';
import 'package:water_eject/core/theme/app_theme.dart';
import 'package:water_eject/core/theme/cubit/theme_cubit.dart';

//tema ve dil ayarlarına göre MaterialApp’i dinamik olarak oluşturan yapı
class ThemeBuilder extends StatelessWidget {
  final bool onboardingCompleted;

  const ThemeBuilder({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: AppConfig.debugBanner,
          title: AppConfig.appTitle,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeState.mode,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: onboardingCompleted ? "/cleaner" : "/onboarding",
        );
      },
    );
  }
}
