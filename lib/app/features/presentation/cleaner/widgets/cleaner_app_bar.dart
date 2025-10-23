import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class CleanerAppBar extends StatelessWidget {
  const CleanerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'app_title'.tr(),
      centerTitle: true,
      subtitle: 'cta_subtitle'.tr(),
      showSettings: true,
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: 'app_title'.tr(),
          children: [Text('disclaimer_body'.tr())],
        );
      },
    );
  }
}
