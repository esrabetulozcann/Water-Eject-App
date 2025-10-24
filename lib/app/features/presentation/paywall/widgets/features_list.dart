import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'feature_row.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureRow(
          //emoji: '🎵',
          icon: AppIcons.musicNote.iconData,
          text: LocaleKeys.unlimited_stereo_cleaning.tr(),
        ),
        SizedBox(height: 4),
        FeatureRow(
          //emoji: '🚫',
          icon: AppIcons.block.iconData,
          text: LocaleKeys.ad_free_experience.tr(),
        ),
        SizedBox(height: 4),
        FeatureRow(
          //emoji: '⚡'
          icon: AppIcons.flash.iconData,
          text: LocaleKeys.custom_frequencies.tr(),
        ),
        SizedBox(height: 4),
        FeatureRow(
          //emoji: '🔊',
          icon: AppIcons.volume.iconData,
          text: LocaleKeys.advanced_audio_quality.tr(),
        ),
      ],
    );
  }
}
