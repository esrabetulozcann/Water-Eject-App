import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'navigation_cubit.dart';
import 'nav_icon.dart';
import 'nav_theme.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (p, c) => p.tab != c.tab,
      builder: (context, state) {
        final cubit = context.read<NavigationCubit>();

        return NavTheme(
          child: NavigationBar(
            selectedIndex: cubit.index,
            onDestinationSelected: cubit.setIndex,
            destinations: [
              NavigationDestination(
                icon: NavIcon(AppIcons.waterDropOutlined.iconData),
                label: LocaleKeys.tabEject.tr(),
              ),
              NavigationDestination(
                icon: NavIcon(AppIcons.graphicEq.iconData),
                label: LocaleKeys.tabTone.tr(),
              ),
              NavigationDestination(
                icon: NavIcon(AppIcons.recordVoice.iconData),
                label: LocaleKeys.tabMeter.tr(),
              ),
              NavigationDestination(
                icon: NavIcon(AppIcons.surroundSound.iconData),
                label: LocaleKeys.tabStereo.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
