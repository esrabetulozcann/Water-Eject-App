import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class MeterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MeterAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: LocaleKeys.db_meter.tr(),
      centerTitle: true,
      subtitle: LocaleKeys.real_time_sound_level.tr(),
      showSettings: false,
      //automaticallyImplyLeading: false, //  hizalar aynı
      onSettingsPressed: () {
        showAboutDialog(
          context: context,
          applicationName: LocaleKeys.db_meter.tr(),
          children: [Text(LocaleKeys.about_dialog_description.tr())],
        );
      },
    );
  }
}
