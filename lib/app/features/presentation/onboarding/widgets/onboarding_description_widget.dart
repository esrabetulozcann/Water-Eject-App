import 'package:flutter/material.dart';

class OnboardingDescriptionWidget extends StatelessWidget {
  final String description;

  const OnboardingDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      description,
      style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
      textAlign: TextAlign.center,
    );
  }
}
