import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/tone/cubit/tone_cubit.dart';
import 'package:water_eject/app/features/presentation/tone/widgets/frequency_display.dart';
import 'package:water_eject/app/features/presentation/tone/widgets/play_button.dart';
import 'package:water_eject/app/features/presentation/tone/widgets/preset_row.dart';
import 'package:water_eject/app/features/presentation/tone/widgets/tone_app_bar.dart';
import 'package:water_eject/core/di/locator.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class ToneView extends StatelessWidget {
  const ToneView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToneCubit>(
      create: (_) => sl<ToneCubit>(),
      child: Scaffold(
        appBar: ToneAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: FrequencyDisplay(),
                        ),

                        Text(
                          LocaleKeys.toneAdjustInstruction.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                              ),
                        ).onlyPadding(bottom: 20),

                        // Preset butonları
                        const PresetRow(presets: [65, 100, 150]),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: PlayButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
