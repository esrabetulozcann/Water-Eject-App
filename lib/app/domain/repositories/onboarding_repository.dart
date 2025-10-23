import 'package:water_eject/app/domain/models/onboarding_models.dart';

abstract class OnboardingRepository {
  bool get isOnboardingCompleted;
  Future<void> completeOnboarding();
  List<OnboardingPage> getOnboardingPages();
}
