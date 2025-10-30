import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingHeaderWidget extends StatelessWidget {
  final int currentPage;
  const OnboardingHeaderWidget({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final total = cubit.totalPages; // ✅
    final colors = Theme.of(context).colorScheme;
    final progress = (currentPage + 1) / total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${currentPage + 1}/$total",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: SizedBox(
                    height: 6,
                    child: Stack(
                      children: [
                        Container(color: colors.surfaceVariant),
                        AnimatedFractionallySizedBox(
                          duration: const Duration(milliseconds: 300),
                          widthFactor: progress.clamp(0, 1),
                          alignment: Alignment.centerLeft,
                          child: Container(color: colors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
