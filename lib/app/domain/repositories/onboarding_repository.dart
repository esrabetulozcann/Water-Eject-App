import 'package:water_eject/app/domain/models/onboarding_model.dart';

abstract class OnboardingRepository {
  bool get isOnboardingCompleted;
  Future<void> completeOnboarding();
  List<OnboardingModel> getOnboardingPages();
}
