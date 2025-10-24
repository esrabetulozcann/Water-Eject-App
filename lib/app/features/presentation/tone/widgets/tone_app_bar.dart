import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class ToneAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToneAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: LocaleKeys.tone_generator.tr(),
      centerTitle: true,
      subtitle: LocaleKeys.tone_subtitle.tr(),
      showSettings: false,
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: LocaleKeys.tone_generator.tr(),
          children: [Text(LocaleKeys.tone_about_description.tr())],
        );
      },
    );
  }
}
