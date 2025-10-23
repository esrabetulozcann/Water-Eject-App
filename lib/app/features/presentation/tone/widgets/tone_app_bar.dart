import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class ToneAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToneAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'tone_generator'.tr(),
      centerTitle: true,
      subtitle: "tone_subtitle".tr(),
      showSettings: true,
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: 'tone_generator'.tr(),
          children: [Text('tone_about_description'.tr())],
        );
      },
    );
  }
}
