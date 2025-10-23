import 'package:flutter/material.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';
import 'package:water_eject/app/features/presentation/onboarding/widgets/onboarding_button_widget.dart';
import 'package:water_eject/app/features/presentation/onboarding/widgets/onboarding_description_widget.dart';
import 'package:water_eject/app/features/presentation/onboarding/widgets/onboarding_image_widget.dart';
import 'package:water_eject/app/features/presentation/onboarding/widgets/onboarding_title_widget.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),

          // Resim widget'ı
          OnboardingImageWidget(imagePath: page.imagePath),

          // Başlık widget'ı
          OnboardingTitleWidget(title: page.title),

          const SizedBox(height: 16),

          // Açıklama widget'ı
          OnboardingDescriptionWidget(description: page.description),

          const Spacer(),

          // Buton widget'ı
          OnboardingButtonWidget(
            isLastPage: isLastPage,
            buttonText: page.buttonText,
            onPressed: onNext,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
