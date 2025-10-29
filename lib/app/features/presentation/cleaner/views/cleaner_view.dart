import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/buttons/start_stop_button.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/cleaner_app_bar.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/duration_slider.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/intensity_selector.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/mode_vibration_row.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/runtime_info_row.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/tone_frequency_controls.dart';

class CleanerView extends StatelessWidget {
  const CleanerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      builder: (context, state) {
        return Scaffold(
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
                                  // Sol blok
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
                                  // Orta blok
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
                                  // Sağ blok
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
                        children: [
                          const CleanerAppBar(),
                          const SizedBox(height: 16),
                          const StartStopButton(),
                          const SizedBox(height: 8),
                          const RuntimeInfoRow(),
                          const SizedBox(height: 16),
                          const IntensitySelector(),
                          const SizedBox(height: 12),
                          const ModeVibrationRow(),
                          const SizedBox(height: 12),
                          const DurationSlider(),
                          const ToneFrequencyControls(),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 60,
                          ),
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
    );
  }
}
