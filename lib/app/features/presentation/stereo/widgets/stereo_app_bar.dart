import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class StereoAppBar extends StatelessWidget {
  const StereoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: "stereo_test".tr(),
      centerTitle: true,
      subtitle: 'stereo_subtitle'.tr(),
      showSettings: true,
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: "stereo_test".tr(),
          children: [Text("stereo_about_description".tr())],
        );
      },
    );
  }
}
