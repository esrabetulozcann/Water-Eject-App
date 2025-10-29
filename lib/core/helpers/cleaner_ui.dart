import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class CleanerUi {
  static void showError(BuildContext context, String? error) {
    if (error == null) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(LocaleKeys.errorAudio.tr())));
  }

  static Widget bubbles(bool show) {
    if (!show) return const SizedBox.shrink();
    return IgnorePointer(
      key: const ValueKey('bubbles-on'),
      child: Stack(
        children: [
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
    );
  }
}
