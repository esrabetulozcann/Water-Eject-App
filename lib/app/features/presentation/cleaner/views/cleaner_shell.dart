import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/cleaner/views/cleaner_view.dart';
import 'package:water_eject/app/common/widgets/app_nav_bar.dart';
import 'package:water_eject/app/common/widgets/navigation_cubit.dart';
import 'package:water_eject/app/features/presentation/db_meter/views/db_meter_view.dart';
import 'package:water_eject/app/features/presentation/stereo/views/stereo_view.dart';
import 'package:water_eject/app/features/presentation/tone/views/tone_view.dart';

class CleanerShell extends StatelessWidget {
  const CleanerShell({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      CleanerView(),
      ToneView(),
      DbMeterView(),
      StereoView(),
    ];

    return BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (p, c) => p.tab != c.tab,
      builder: (context, state) {
        //final index = NavigationCubit().index;

        final i = context.read<NavigationCubit>().index;

        return Scaffold(
          body: SafeArea(child: pages[i]),
          bottomNavigationBar: const AppNavBar(),
        );
      },
    );
  }
}
