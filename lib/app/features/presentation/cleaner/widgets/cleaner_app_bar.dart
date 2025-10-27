import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';
import 'package:water_eject/app/features/presentation/setting/views/setting_page.dart';

class CleanerAppBar extends StatelessWidget {
  const CleanerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      elevation: 0,
      title: LocaleKeys.app_title.tr(),
      centerTitle: true,
      subtitle: LocaleKeys.cta_subtitle.tr(),
      showSettings: true,
      onSettingsPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SettingPage();
            },
          ),
        );
        /*showAboutDialog(
          context: context,
          applicationName: LocaleKeys.app_title.tr(),
          children: [Text(LocaleKeys.disclaimer_body.tr())],
        );
        */
      },

      //  backgroundColor: const Color(0xFFE1F5FE),
    );
  }
}
