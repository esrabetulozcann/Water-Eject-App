import 'package:flutter/material.dart';

class OnboardingTitleWidget extends StatelessWidget {
  final String title;

  const OnboardingTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: colors.primary,
      ),
      textAlign: TextAlign.center,
    );
  }
}
