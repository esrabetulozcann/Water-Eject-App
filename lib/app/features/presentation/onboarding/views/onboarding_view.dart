import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_header_widget.dart';
import '../widgets/onboarding_content_widget.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingContent(),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, currentPage) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Header - Progress bar + Skip butonu
                OnboardingHeaderWidget(currentPage: currentPage),

                // İçerik - Sayfa widget'ı
                OnboardingContentWidget(currentPage: currentPage),
              ],
            ),
          ),
        );
      },
    );
  }
}
