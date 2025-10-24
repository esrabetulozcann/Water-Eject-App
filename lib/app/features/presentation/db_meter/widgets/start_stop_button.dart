import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class StartStopButton extends StatelessWidget {
  final bool isMeasuring;
  final VoidCallback onPressed;

  const StartStopButton({
    super.key,
    required this.isMeasuring,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(AppIcons.mic.iconData),
        label: Text(isMeasuring ? LocaleKeys.stop.tr() : LocaleKeys.start.tr()),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
