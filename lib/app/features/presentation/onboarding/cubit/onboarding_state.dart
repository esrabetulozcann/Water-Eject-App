abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {
  final int pageIndex;

  OnboardingInitial(this.pageIndex);
}
