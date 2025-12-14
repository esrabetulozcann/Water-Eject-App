import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

class SettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(AppIcons.chevronLeft.iconData),
      ),
      title: LocaleKeys.settingTitle.tr(),
      centerTitle: true,
      showSettings: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
