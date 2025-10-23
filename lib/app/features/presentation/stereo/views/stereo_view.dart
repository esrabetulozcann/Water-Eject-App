import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_cubit.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_state.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/auto_loop_switch.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/channel_button.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/start_button.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/stereo_app_bar.dart';

class StereoView extends StatelessWidget {
  const StereoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const StereoAppBar(),
            const SizedBox(height: 8),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'stereo_start_test'.tr(),
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  BlocBuilder<StereoCubit, StereoState>(
                    buildWhen: (p, c) =>
                        p.active != c.active || p.selected != c.selected,
                    builder: (_, state) {
                      final leftSelected = state.selected == StereoChannel.left;
                      final rightSelected =
                          state.selected == StereoChannel.right;
                      final leftActive =
                          state.active == StereoChannel.left && state.isTesting;
                      final rightActive =
                          state.active == StereoChannel.right &&
                          state.isTesting;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ChannelButton(
                            label: "stereo_left_channel".tr(),
                            side: StereoChannel.left,
                            isActive: leftActive,
                            isSelected: leftSelected,
                            onTap: () => context.read<StereoCubit>().tapLeft(),
                          ),
                          ChannelButton(
                            label: "stereo_right_channel".tr(),
                            side: StereoChannel.right,
                            isActive: rightActive,
                            isSelected: rightSelected,
                            onTap: () => context.read<StereoCubit>().tapRight(),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                  const AutoLoopSwitch(),
                ],
              ),
            ),

            const StartButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
