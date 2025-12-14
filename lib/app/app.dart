import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/bloc/app_bloc_provider.dart';
import 'package:water_eject/app/common/localization/localization_wrapper.dart';
import 'package:water_eject/app/common/theme/theme_builder.dart';
import 'package:water_eject/core/config/localization_config.dart';

//bütün altyapıyı (dil desteği, tema, Cubit’ler, vs.) tek yerde kurup uygulamayı ayağa kaldıran yapı.
class WaterEjectApp extends StatelessWidget {
  final bool onboardingCompleted;

  const WaterEjectApp({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: LocalizationConfig.supportedLocales,
      path: LocalizationConfig.translationsPath,
      fallbackLocale: LocalizationConfig.fallbackLocale,
      child: AppCore(onboardingCompleted: onboardingCompleted),
    );
  }
}

class AppCore extends StatelessWidget {
  final bool onboardingCompleted;

  const AppCore({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: LocalizationWrapper(
        child: ThemeBuilder(onboardingCompleted: onboardingCompleted),
      ),
    );
  }
}
