import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final String imagePath;
  final String? buttonText;

  const OnboardingPageModel({
    required this.title,
    required this.description,
    required this.imagePath,
    this.buttonText,
  });
}

class OnboardingData {
  static final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: LocaleKeys.onboardingPage1Title.tr(),
      description: LocaleKeys.onboardingPage1Description.tr(),
      imagePath: 'assets/onboarding/water_eject2.jpg',
    ),
    OnboardingPageModel(
      title: LocaleKeys.onboardingPage2Title.tr(),
      description: LocaleKeys.onboardingPage2Description.tr(),
      imagePath: 'assets/onboarding/usage.png',
    ),
    OnboardingPageModel(
      title: LocaleKeys.onboardingPage3Title.tr(),
      description: LocaleKeys.onboardingPage3Description.tr(),
      imagePath: 'assets/onboarding/disclaimer.jpg',
      buttonText: LocaleKeys.onboardingPage3ButtonText.tr(),
    ),
  ];
}
