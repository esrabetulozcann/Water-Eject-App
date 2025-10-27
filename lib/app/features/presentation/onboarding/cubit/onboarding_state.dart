import 'package:equatable/equatable.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final List<OnboardingPageModel> pages;
  final int currentPage;

  const OnboardingLoaded({required this.pages, required this.currentPage});

  bool get isFirstPage => currentPage == 0;
  bool get isLastPage => currentPage == pages.length - 1;

  OnboardingLoaded copyWith({
    List<OnboardingPageModel>? pages,
    int? currentPage,
  }) {
    return OnboardingLoaded(
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [pages, currentPage];
}

class OnboardingCompleted extends OnboardingState {}
