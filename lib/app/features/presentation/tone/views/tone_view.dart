import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../widgets/frequency_display.dart';
import '../widgets/preset_row.dart';
import '../widgets/play_button.dart';

class ToneView extends StatelessWidget {
  const ToneView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
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
                    LocaleKeys.tone_adjust_instruction.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

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
    );
  }
}
