import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/router/app_router.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';

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
        AppRouter.push(context, AppRouter.setting);
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SettingView();
            },
          ),
        );
        */
      },
    );
  }
}
