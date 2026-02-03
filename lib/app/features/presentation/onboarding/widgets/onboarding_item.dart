import 'package:flutter/material.dart';
import 'package:water_eject/app/domain/models/onboarding_model.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(model.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Title
            Expanded(
              flex: 2,
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ).onlyPadding(top: 85),
            ),

            // Description
            Expanded(
              flex: 2,
              child: Text(
                model.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ).onlyPadding(top: 140),
            ),
          ],
        ).onlyPadding(bottom: 30),
      ),
    );
  }
}
