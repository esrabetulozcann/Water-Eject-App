import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class MeterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MeterAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: "db_meter".tr(),
      centerTitle: true,
      subtitle: "real_time_sound_level".tr(),
      showSettings: true,
      //automaticallyImplyLeading: false, //  hizalar aynı
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: "db_meter".tr(),
          children: [Text("about_dialog_description".tr())],
        );
      },
    );
  }
}
