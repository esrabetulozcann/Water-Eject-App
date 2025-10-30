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
          //🎵,
          icon: AppIcons.musicNote.iconData,
          text: LocaleKeys.unlimitedStereoCleaning.tr(),
        ),
        SizedBox(height: 4),
        FeatureRow(
          //🚫
          icon: AppIcons.block.iconData,
          text: LocaleKeys.adFreeExperience.tr(),
        ),
        SizedBox(height: 4),
        FeatureRow(
          //⚡
          icon: AppIcons.flash.iconData,
          text: LocaleKeys.customFrequencies.tr(),
        ),
        SizedBox(height: 4),
        FeatureRow(
          //🔊
          icon: AppIcons.volume.iconData,
          text: LocaleKeys.advancedAudioQuality.tr(),
        ),
      ],
    );
  }
}
