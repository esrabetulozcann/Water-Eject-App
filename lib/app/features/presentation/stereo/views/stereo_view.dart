import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/enum/stereo_channel_enum.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_cubit.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_state.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/auto_loop_switch.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/channel_button.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/start_button.dart';
import 'package:water_eject/app/features/presentation/stereo/widgets/stereo_app_bar.dart';
import 'package:water_eject/core/di/locator.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class StereoView extends StatelessWidget {
  const StereoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StereoCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const StereoAppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.stereoStartTest.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ).onlyPadding(bottom: 24),

                          BlocBuilder<StereoCubit, StereoState>(
                            buildWhen: (p, c) =>
                                p.active != c.active ||
                                p.selected != c.selected,
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ChannelButton(
                                    label: LocaleKeys.stereoLeftChannel.tr(),
                                    side: StereoChannel.left,
                                    isActive:
                                        state.active == StereoChannel.left &&
                                        state.isTesting,
                                    isSelected:
                                        state.selected == StereoChannel.left,
                                    onTap: () =>
                                        context.read<StereoCubit>().tapLeft(),
                                  ),
                                  ChannelButton(
                                    label: LocaleKeys.stereoRightChannel.tr(),
                                    side: StereoChannel.right,
                                    isActive:
                                        state.active == StereoChannel.right &&
                                        state.isTesting,
                                    isSelected:
                                        state.selected == StereoChannel.right,
                                    onTap: () =>
                                        context.read<StereoCubit>().tapRight(),
                                  ),
                                ],
                              );
                            },
                          ),

                          const AutoLoopSwitch().onlyPadding(top: 24),
                        ],
                      ),
                    ),
                    const StartButton().onlyPadding(bottom: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
