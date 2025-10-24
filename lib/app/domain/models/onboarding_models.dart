import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;
  final String? buttonText;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    this.buttonText,
  });
}

class OnboardingData {
  static final List<OnboardingPage> pages = [
    OnboardingPage(
      title: LocaleKeys.onboarding_page1_title.tr(),
      description: LocaleKeys.onboarding_page1_description.tr(),
      imagePath: 'assets/onboarding/water_eject2.jpg',
    ),
    OnboardingPage(
      title: LocaleKeys.onboarding_page2_title.tr(),
      description: LocaleKeys.onboarding_page2_description.tr(),
      imagePath: 'assets/onboarding/usage.png',
    ),
    OnboardingPage(
      title: LocaleKeys.onboarding_page3_title.tr(),
      description: LocaleKeys.onboarding_page3_description.tr(),
      imagePath: 'assets/onboarding/disclaimer.jpg',
      buttonText: LocaleKeys.onboarding_page3_buttonText.tr(),
    ),
  ];
}
