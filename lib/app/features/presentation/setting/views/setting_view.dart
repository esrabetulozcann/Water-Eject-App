import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/domain/models/settings_option_model.dart';
import 'package:water_eject/app/features/presentation/about/views/about_view.dart';

import 'package:water_eject/app/features/presentation/setting/cubit/setting_cubit.dart';
import 'package:water_eject/app/features/presentation/setting/cubit/setting_state.dart';

import 'package:water_eject/app/features/presentation/setting/widgets/setting_app_bar.dart';
import 'package:water_eject/app/features/presentation/setting/widgets/settings_expandable_choice_tile.dart';
import 'package:water_eject/app/features/presentation/setting/widgets/settings_section.dart';
import 'package:water_eject/app/features/presentation/setting/widgets/settings_tile.dart';

import 'package:water_eject/core/cubit/localization_cubit.dart';
import 'package:water_eject/core/di/locator.dart';
import 'package:water_eject/core/theme/cubit/theme_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const SettingAppBar(),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SettingsSection(
                  children: [
                    // THEME
                    SettingsExpandableChoiceTile<String>(
                      title: LocaleKeys.settingTheme.tr(),
                      leadingIcon: AppIcons.darkMode.iconData,
                      selected: state.isDarkMode ? 'dark' : 'light',
                      options: [
                        SettingsOption(
                          value: 'light',
                          label: LocaleKeys.settingLightMode.tr(),
                          icon: AppIcons.sunnyRounded.iconData,
                        ),
                        SettingsOption(
                          value: 'dark',
                          label: LocaleKeys.settingDarkMode.tr(),
                          icon: AppIcons.darkModeRounded.iconData,
                        ),
                      ],
                      onChanged: (val) {
                        final wantsDark = (val == 'dark');
                        context.read<SettingCubit>().toggleDarkMode(wantsDark);
                        context.read<ThemeCubit>().toggle(wantsDark);
                      },
                    ),

                    // Language (TR/EN)
                    SettingsExpandableChoiceTile<String>(
                      title: LocaleKeys.settingLanguage.tr(),
                      leadingIcon: AppIcons.language.iconData,
                      selected: state.isEnglish ? 'en' : 'tr',
                      options: const [
                        SettingsOption(value: 'tr', label: 'Türkçe 🇹🇷'),
                        SettingsOption(value: 'en', label: 'English 🇬🇧'),
                      ],
                      onChanged: (val) async {
                        final isEnglish = val == 'en';
                        context.read<SettingCubit>().toggleLanguage(isEnglish);

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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const AboutView();
                            },
                          ),
                        );
                      },
                    ),
                    SettingsTile(
                      icon: AppIcons.share.iconData,
                      title: LocaleKeys.settingAppShare.tr(),
                      onTap: () {},
                    ),
                    SettingsTile(
                      icon: AppIcons.star.iconData,
                      title: LocaleKeys.settingAppRate.tr(),
                      onTap: () {},
                    ),
                    SettingsTile(
                      icon: AppIcons.privacy.iconData,
                      title: LocaleKeys.settingPrivacyPolicy.tr(),
                      onTap: () {},
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
