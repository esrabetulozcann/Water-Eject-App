import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        icon: const Icon(Icons.mic),
        label: Text(isMeasuring ? "stop".tr() : "start".tr()),
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
