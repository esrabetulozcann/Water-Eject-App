import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class StereoAppBar extends StatelessWidget {
  const StereoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: LocaleKeys.stereo_test.tr(),
      centerTitle: true,
      subtitle: LocaleKeys.stereo_subtitle.tr(),
      showSettings: false,
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: LocaleKeys.stereo_test.tr(),
          children: [Text(LocaleKeys.stereo_about_description.tr())],
        );
      },
    );
  }
}
