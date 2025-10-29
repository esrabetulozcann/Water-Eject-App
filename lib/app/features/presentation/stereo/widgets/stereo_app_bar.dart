import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class StereoAppBar extends StatelessWidget {
  const StereoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: LocaleKeys.stereoTest.tr(),
      centerTitle: true,
      subtitle: LocaleKeys.stereoSubtitle.tr(),
      showSettings: false,
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: LocaleKeys.stereoTest.tr(),
          children: [Text(LocaleKeys.stereoAboutDescription.tr())],
        );
      },
    );
  }
}
