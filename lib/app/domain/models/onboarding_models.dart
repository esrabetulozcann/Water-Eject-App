import 'package:easy_localization/easy_localization.dart';

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
      title: 'onboarding_page1_title'.tr(),
      description: 'onboarding_page1_description'.tr(),
      imagePath: 'assets/onboarding/water_eject2.jpg',
    ),
    OnboardingPage(
      title: 'onboarding_page2_title'.tr(),
      description: 'onboarding_page2_description'.tr(),
      imagePath: 'assets/onboarding/usage.png',
    ),
    OnboardingPage(
      title: 'onboarding_page3_title'.tr(),
      description: 'onboarding_page3_description'.tr(),
      imagePath: 'assets/onboarding/disclaimer.jpg',
      buttonText: 'onboarding_page3_buttonText'.tr(),
    ),
  ];
}
