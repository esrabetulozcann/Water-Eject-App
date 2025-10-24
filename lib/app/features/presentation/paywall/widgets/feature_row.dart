import 'package:flutter/material.dart';

class FeatureRow extends StatelessWidget {
  //final String emoji;
  final String text;
  final IconData? icon;

  const FeatureRow({
    super.key,
    //required this.emoji,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
