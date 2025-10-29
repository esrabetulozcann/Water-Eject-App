import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';

import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/app/features/data/cleaner/audio/just_audio_engine.dart';
import 'package:water_eject/app/features/data/cleaner/haptics/vibration_service_impl.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/buttons/start_stop_button.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/cleaner_app_bar.dart';

// Widgets
import '../widgets/runtime_info_row.dart';
import '../widgets/intensity_selector.dart';
import '../widgets/mode_vibration_row.dart';
import '../widgets/duration_slider.dart';
import '../widgets/tone_frequency_controls.dart';

class CleanerPage extends StatelessWidget {
  const CleanerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CleanerCubit(
        audio: JustAudioEngine(),
        vibration: VibrationServiceImpl(),
      ),
      child: const _CleanerView(),
    );
  }
}

class _CleanerView extends StatelessWidget {
  const _CleanerView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      builder: (context, state) {
        //final screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          // backgroundColor: const Color(0xFFE1F5FE), //  0xFFB3E5FC
          body: Stack(
            children: [
              // === BACKGROUND ===
              IgnorePointer(
                // arka plan dokunmaları engellemesin
                child: Stack(
                  children: [
                    // === BACKGROUND ===
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
                    listener: (context, state) {
                      if (state.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(LocaleKeys.errorAudio.tr())),
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CleanerAppBar(),
                          SizedBox(height: 16),
                          StartStopButton(),
                          SizedBox(height: 8),
                          RuntimeInfoRow(),
                          SizedBox(height: 16),
                          IntensitySelector(),
                          SizedBox(height: 12),
                          ModeVibrationRow(),
                          SizedBox(height: 12),
                          DurationSlider(),
                          ToneFrequencyControls(),

                          // Navbar için boşluk
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
