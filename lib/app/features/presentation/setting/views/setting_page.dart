import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

import 'package:water_eject/app/features/presentation/setting/cubit/setting_cubit.dart';
import 'package:water_eject/app/features/presentation/setting/cubit/setting_state.dart';

import 'package:water_eject/app/features/presentation/setting/widgets/setting_app_bar.dart';
import 'package:water_eject/app/features/presentation/setting/widgets/settings_section.dart';
import 'package:water_eject/app/features/presentation/setting/widgets/settings_switch_tile.dart';
import 'package:water_eject/app/features/presentation/setting/widgets/settings_tile.dart';

import 'package:water_eject/core/cubit/localization_cubit.dart';
import 'package:water_eject/core/di/locator.dart';
import 'package:water_eject/core/theme/cubit/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1) Mevcut tema & dil bilgisini yukarıdaki cubit'lerden çek
    final isDarkNow = context.select<ThemeCubit, bool>(
      (c) => c.state.mode == ThemeMode.dark,
    );

    final isEnglishNow = context.select<LocaleCubit, bool>(
      (c) => c.state.locale.languageCode == 'en',
    );

    return BlocProvider(
      create: (_) => sl<SettingCubit>(
        param1: (isDark: isDarkNow, isEnglish: isEnglishNow),
      ),
      //create: (_) => SettingCubit(isDark: isDarkNow, isEnglish: isEnglishNow),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          final cubit = context.read<SettingCubit>();

          final darkNextTitle = state.isDarkMode
              ? LocaleKeys.settingLightMode.tr()
              : LocaleKeys.settingDarkMode.tr();
          final darkNextIcon = state.isDarkMode
              ? Icons.wb_sunny_rounded
              : AppIcons.darkMode.iconData;

          final langNextTitle = state.isEnglish
              ? LocaleKeys.settingLanguageTr.tr()
              : LocaleKeys.settingLanguageEn.tr();
          final langNextIcon = state.isEnglish
              ? Icons.translate
              : AppIcons.language.iconData;

          return Scaffold(
            appBar: const SettingAppBar(),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SettingsSection(
                  children: [
                    // 🌙/🌞 Tema anahtarı
                    SettingsSwitchTile(
                      icon: darkNextIcon,
                      title: darkNextTitle,
                      value: state.isDarkMode,
                      onChanged: (val) {
                        // 1) UI aynası güncellensin
                        cubit.toggleDarkMode(val);
                        // 2) Gerçek iş: ThemeCubit durumu ve persist
                        context.read<ThemeCubit>().toggle(val);
                      },
                    ),

                    // 🌐 Dil anahtarı
                    SettingsSwitchTile(
                      icon: langNextIcon,
                      title: langNextTitle,
                      value: state.isEnglish,
                      onChanged: (isEnglish) async {
                        // 1) UI aynası güncellensin
                        cubit.toggleLanguage(isEnglish);

                        // 2) Gerçek iş: LocaleCubit + easy_localization
                        final locale = isEnglish
                            ? const Locale('en', 'US')
                            : const Locale('tr', 'TR');

                        context.read<LocaleCubit>().setLocale(locale);
                        await context.setLocale(locale);
                        if (!context.mounted) return;
                      },
                    ),
                  ],
                ),

                SettingsSection(
                  children: [
                    SettingsTile(
                      icon: AppIcons.info.iconData,
                      title: LocaleKeys.settingAbout.tr(),
                    ),
                    SettingsTile(
                      icon: AppIcons.share.iconData,
                      title: LocaleKeys.settingAppShare.tr(),
                    ),
                    SettingsTile(
                      icon: AppIcons.star.iconData,
                      title: LocaleKeys.settingAppRate.tr(),
                    ),
                    SettingsTile(
                      icon: AppIcons.privacy.iconData,
                      title: LocaleKeys.settingPrivacyPolicy.tr(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
