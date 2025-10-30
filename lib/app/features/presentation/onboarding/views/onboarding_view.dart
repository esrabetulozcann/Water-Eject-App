import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/core/di/locator.dart';
import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_header_widget.dart';
import '../widgets/onboarding_content_widget.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingData.pages; // mevcut model listen
    return BlocProvider(
      // create: (_) => OnboardingCubit(totalPages: pages.length),
      create: (_) => sl<OnboardingCubit>(param1: pages.length),
      child: _OnboardingContent(pages: pages),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent({required this.pages});
  final List<OnboardingPageModel> pages;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, currentPage) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeaderWidget(currentPage: currentPage),
                OnboardingContentWidget(pages: pages), // stateless olacak
              ],
            ),
          ),
        );
      },
    );
  }
}
