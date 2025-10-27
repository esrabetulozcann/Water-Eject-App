import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'navigation_cubit.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (p, c) => p.tab != c.tab,
      builder: (context, state) {
        final cubit = context.read<NavigationCubit>();
        return NavigationBar(
          // backgroundColor: const Color.fromARGB(255, 177, 193, 234),
          selectedIndex: cubit.index,
          onDestinationSelected: cubit.setIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(AppIcons.waterDropOutlined.iconData),
              label: LocaleKeys.tab_eject.tr(),
            ),
            NavigationDestination(
              icon: Icon(AppIcons.graphicEq.iconData),
              label: LocaleKeys.tab_tone.tr(),
            ),
            NavigationDestination(
              icon: Icon(AppIcons.recordVoice.iconData),
              label: LocaleKeys.tab_meter.tr(),
            ),
            NavigationDestination(
              icon: Icon(AppIcons.surroundSound.iconData),
              label: LocaleKeys.tab_stereo.tr(),
            ),
          ],
        );
      },
    );
  }
}
