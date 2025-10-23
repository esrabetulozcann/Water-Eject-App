import 'package:flutter/material.dart';

class OnboardingImageWidget extends StatelessWidget {
  final String imagePath;

  const OnboardingImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 40),
      child: Image.asset(imagePath, fit: BoxFit.contain),
    );
  }
}
