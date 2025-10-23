import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'feature_row.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureRow(emoji: '🎵', text: 'unlimited_stereo_cleaning'.tr()),
        SizedBox(height: 4),
        FeatureRow(emoji: '🚫', text: 'ad_free_experience'.tr()),
        SizedBox(height: 4),
        FeatureRow(emoji: '⚡', text: 'custom_frequencies'.tr()),
        SizedBox(height: 4),
        FeatureRow(emoji: '🔊', text: 'advanced_audio_quality'.tr()),
      ],
    );
  }
}
