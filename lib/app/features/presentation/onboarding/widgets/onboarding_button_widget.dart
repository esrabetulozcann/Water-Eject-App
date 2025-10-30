// onboarding_button_widget.dart
import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:water_eject/app/common/constant/localization_keys.dart';

class OnboardingButtonWidget extends StatelessWidget {
  final bool isLastPage;
  final String? buttonText; // <-- nullable kabul ediyoruz
  final VoidCallback onPressed;

  const OnboardingButtonWidget({
    super.key,
    required this.isLastPage,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Eğer buttonText boş/null ise fallback kullan:
    final label = (buttonText != null && buttonText!.trim().isNotEmpty)
        ? buttonText!.trim()
        : (isLastPage ? 'I Agree' : 'Next');
    // Lokalizasyon kullanacaksan:
    // : (isLastPage ? LocaleKeys.iAgree.tr() : LocaleKeys.next.tr());

    final colors = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 56,
        minWidth: double.infinity,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
