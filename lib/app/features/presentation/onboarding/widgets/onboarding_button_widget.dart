import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class OnboardingButtonWidget extends StatelessWidget {
  final bool isLastPage;
  final String? buttonText;
  final VoidCallback onPressed;

  const OnboardingButtonWidget({
    super.key,
    required this.isLastPage,
    this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          _getButtonText(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getButtonText() {
    if (isLastPage) {
      return buttonText ?? LocaleKeys.start.tr();
    }
    return LocaleKeys.next.tr();
  }
}
