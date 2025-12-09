import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/start_stop_button.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/cleaner_app_bar.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/duration_slider.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/intensity_selector.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/mode_vibration_row.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/runtime_info_row.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/tone_frequency_controls.dart';
import 'package:water_eject/core/di/locator.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class CleanerView extends StatelessWidget {
  const CleanerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CleanerCubit>()..init(),
      child: BlocBuilder<CleanerCubit, CleanerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CleanerAppBar(),
            body: Stack(
              children: [
                IgnorePointer(
                  child: Stack(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: state.showBubbles
                            ? IgnorePointer(
                                key: const ValueKey('bubbles-on'),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: Lottie.asset(
                                            'assets/animation/Bubbles.json',
                                            fit: BoxFit.fitHeight,
                                            repeat: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: Lottie.asset(
                                            'assets/animation/Bubbles.json',
                                            fit: BoxFit.fitHeight,
                                            repeat: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: FractionallySizedBox(
                                          widthFactor: 0.4,
                                          child: Lottie.asset(
                                            'assets/animation/Bubbles.json',
                                            fit: BoxFit.fitHeight,
                                            repeat: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  child: SafeArea(
                    bottom: false,
                    child: BlocListener<CleanerCubit, CleanerState>(
                      listenWhen: (prev, curr) => prev.error != curr.error,
                      listener: (context, s) {
                        if (s.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(LocaleKeys.errorAudio.tr())),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          spacing: 8,
                          children: [
                            const StartStopButton().onlyPadding(top: 8),
                            const RuntimeInfoRow(),
                            const IntensitySelector().onlyPadding(top: 8),
                            const ModeVibrationRow().onlyPadding(top: 4),
                            const DurationSlider().onlyPadding(top: 4),
                            const ToneFrequencyControls(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
