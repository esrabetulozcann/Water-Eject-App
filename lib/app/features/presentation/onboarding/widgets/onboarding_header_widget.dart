import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';
import 'page_indicator.dart';

class OnboardingHeaderWidget extends StatelessWidget {
  final int currentPage;

  const OnboardingHeaderWidget({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Progress Bar - solda
          Expanded(
            child: PageIndicator(
              currentPage: currentPage,
              pageCount: OnboardingCubit.totalPages,
              onPageSelected: (page) => cubit.goToPage(page),
            ),
          ),

          // Atla butonu - sağda (sadece ilk iki sayfada)
          if (!cubit.isLastPage) _buildSkipButton(context),
        ],
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return TextButton(
      onPressed: () => _completeOnboarding(context),
      child: Text(
        'Atla',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }

  void _completeOnboarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/cleaner');
  }
}
