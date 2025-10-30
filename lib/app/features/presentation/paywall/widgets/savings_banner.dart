import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/colors.dart';

class SavingsBanner extends StatelessWidget {
  const SavingsBanner({super.key, required this.visible, required this.text});
  final bool visible;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Her zaman aynı yüksekliği tutsun
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: visible
            ? colors.primary.withOpacity(0.10)
            : AppColors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Opacity(
        opacity: visible ? 1 : 0,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: colors.primary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
