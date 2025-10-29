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
import 'package:water_eject/core/theme/cubit/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingCubit(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          final cubit = context.read<SettingCubit>();

          final isDarkNow = state.isDarkMode;
          final darkNextTitle = isDarkNow
              ? LocaleKeys.settingLightMode
                    .tr() // koyuysa Light Mode göster
              : LocaleKeys.settingDarkMode.tr(); // açıksa Dark Mode göster
          final darkNextIcon = isDarkNow
              ? Icons
                    .wb_sunny_rounded // koyuysa güneş ikonunu göster
              : AppIcons.darkMode.iconData; // açıksa ay (dark) ikonunu göster

          final isEnglishNow = state.isEnglish;
          final langNextTitle = isEnglishNow
              ? LocaleKeys.settingLanguageTr
                    .tr() // İngilizce ise Türkçe yaz
              : LocaleKeys.settingLanguageEn.tr(); // Türkçe ise English yaz
          final langNextIcon = isEnglishNow
              ? Icons.translate
              : AppIcons.language.iconData;

          return Scaffold(
            appBar: SettingAppBar(),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SettingsSection(
                  children: [
                    // 🌙/🌞 Tema anahtarı
                    SettingsSwitchTile(
                      icon: darkNextIcon,
                      title: darkNextTitle,
                      value: isDarkNow,
                      onChanged: (val) {
                        cubit.toggleDarkMode(val);
                        context.read<ThemeCubit>().toggle(val);
                      },
                    ),

                    //  Dil
                    SettingsSwitchTile(
                      icon: langNextIcon,
                      title: langNextTitle,
                      value: isEnglishNow,
                      onChanged: (isEnglish) async {
                        cubit.toggleLanguage(isEnglish);
                        final locale = isEnglish
                            ? const Locale('en', 'US')
                            : const Locale('tr', 'TR');
                        context.read<LocaleCubit>().setLocale(locale);
                        await context.setLocale(locale);
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
