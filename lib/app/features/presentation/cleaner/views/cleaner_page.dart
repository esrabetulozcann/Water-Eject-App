import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<CleanerCubit, CleanerState>(
            listenWhen: (prev, curr) => prev.error != curr.error,
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocaleKeys.error_audio.tr())),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // CleanerHeader(),
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
                  ToneFrequencyControls(), // kendi içinde mode==tone kontrol ediyor
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
