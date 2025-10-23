import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';
import 'package:water_eject/app/features/presentation/onboarding/views/onboarding_page.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingContentWidget extends StatelessWidget {
  final int currentPage;

  const OnboardingContentWidget({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final pageData = OnboardingData.pages[currentPage];

    return Expanded(
      child: OnboardingPageWidget(
        page: pageData,
        isLastPage: cubit.isLastPage,
        onNext: () => _handleNextButton(context, cubit),
        onSkip: () => _completeOnboarding(context),
      ),
    );
  }

  void _handleNextButton(BuildContext context, OnboardingCubit cubit) {
    if (cubit.isLastPage) {
      _completeOnboarding(context);
    } else {
      cubit.nextPage();
    }
  }

  void _completeOnboarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/cleaner');
  }
}
