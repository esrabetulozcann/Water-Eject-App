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

          return Scaffold(
            appBar: SettingAppBar(),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SettingsSection(
                  children: [
                    SettingsSwitchTile(
                      icon: AppIcons.darkMode.iconData,
                      title: LocaleKeys.setting_dark_mode.tr(),
                      value: state.isDarkMode,
                      onChanged: (val) {
                        // 1) Kendi cubit’inin state’ini güncelle (UI tutarlılığı)
                        cubit.toggleDarkMode(val);
                        // 2) Uygulama temasını gerçek Cubit’e bildir (global etki)
                        context.read<ThemeCubit>().toggle(val);
                      },
                    ),

                    SettingsSwitchTile(
                      icon: AppIcons.language.iconData,
                      title: LocaleKeys.setting_language_en.tr(),
                      value: state.isEnglish,
                      onChanged: (isEnglish) async {
                        // 1) Kendi cubit’inin state’ini güncelle
                        cubit.toggleLanguage(isEnglish);
                        // 2) LocaleCubit’e bildir (global etki)
                        final locale = isEnglish
                            ? const Locale('en', 'US')
                            : const Locale('tr', 'TR');
                        context.read<LocaleCubit>().setLocale(locale);
                        // 3) EasyLocalization zaten main.dart’ta BlocListener ile locale’ı güncelliyor.
                        // (İstersen burada da güvence olsun diye:)
                        await context.setLocale(locale);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingsSection(
                  children: [
                    SettingsTile(
                      icon: AppIcons.info.iconData,
                      title: LocaleKeys.setting_abaout.tr(),
                    ),
                    SettingsTile(
                      icon: AppIcons.share.iconData,
                      title: LocaleKeys.setting_app_share.tr(),
                    ),
                    SettingsTile(
                      icon: AppIcons.star.iconData,
                      title: LocaleKeys.setting_app_rate.tr(),
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
