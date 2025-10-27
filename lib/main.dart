import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/router/app_router.dart';
import 'package:water_eject/app/domain/services/premium_service.dart';
import 'package:water_eject/app/common/widgets/navigation_cubit.dart';
import 'package:water_eject/app/features/presentation/paywall/cubit/paywall_selection_cubit.dart';
import 'package:water_eject/app/features/presentation/paywall/cubit/premium_cubit.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      child: const WaterEjectApp(),
    ),
  );
}

class WaterEjectApp extends StatelessWidget {
  const WaterEjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..load()),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
          create: (_) => PremiumCubit(PremiumService())..checkPremiumStatus(),
        ),
        BlocProvider(create: (_) => PaywallSelectionCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Water Eject',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.mode,

            // localization
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              EasyLocalization.of(context)!.delegate,
            ],

            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.onboarding,
          );
        },
      ),
    );
  }
}
