import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';
import 'package:water_eject/app/features/presentation/onboarding/views/onboarding_page.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({
    super.key,
    required this.pages,
    required this.onComplete,
  });

  final List<OnboardingPageModel> pages;
  final Future<void> Function() onComplete;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return Expanded(
      child: PageView.builder(
        controller: cubit.pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: pages.length,
        onPageChanged: cubit.goToPage,
        itemBuilder: (_, i) {
          final isLast = i == pages.length - 1;
          return OnboardingPageWidget(
            page: pages[i],
            isLastPage: isLast,
            onNext: () async => isLast ? onComplete() : cubit.nextPage(),
            onSkip: onComplete,
          );
        },
      ),
    );
  }
}
