import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
          selectedIndex: cubit.index,
          onDestinationSelected: cubit.setIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.water_drop_outlined),
              label: 'tab_eject'.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.graphic_eq),
              label: 'tab_tone'.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.record_voice_over),
              label: 'tab_meter'.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.surround_sound),
              label: 'tab_stereo'.tr(),
            ),
          ],
        );
      },
    );
  }
}
