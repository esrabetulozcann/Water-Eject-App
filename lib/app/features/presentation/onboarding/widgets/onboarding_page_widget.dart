import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';
import 'package:water_eject/core/localization/locale_keys.g.dart';
import 'onboarding_button_widget.dart';
import 'onboarding_title_widget.dart';
import 'onboarding_description_widget.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageModel page;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.surface, colors.surfaceVariant.withOpacity(0.4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          children: [
            const Spacer(),

            // Görsel alanı
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors.primary.withOpacity(0.15),
                    AppColors.transparent,
                  ],
                  radius: 0.85,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.12),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(page.imagePath, fit: BoxFit.contain),
                ),
              ),
            ),

            const SizedBox(height: 24),
            OnboardingTitleWidget(title: page.title),
            const SizedBox(height: 12),
            OnboardingDescriptionWidget(description: page.description),

            const Spacer(),

            // Alt CTA alanı: birincil buton + opsiyonel alt link
            OnboardingButtonWidget(
              isLastPage: isLastPage,
              buttonText: page.buttonText,
              onPressed: onNext,
            ),
            const SizedBox(height: 12),

            // İsteğe bağlı: “Learn more / Privacy” gibi küçük link
            if (!isLastPage)
              TextButton(
                onPressed: onSkip,
                child: Text(
                  LocaleKeys.skip.tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
