import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';
import 'package:water_eject/app/features/presentation/setting/views/setting_view.dart';

class CleanerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CleanerAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      elevation: 0,
      title: LocaleKeys.appTitle.tr(),
      centerTitle: true,
      subtitle: LocaleKeys.ctaSubtitle.tr(),
      showSettings: true,
      onSettingsPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SettingView();
            },
          ),
        );
      },
    );
  }
}
