import 'package:flutter/material.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final bool value;
  final IconData icon;
  final bool enable;
  final ValueChanged<bool>? onChanged;

  const OptionCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onChanged,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cs.surfaceVariant.withOpacity(0.4),
        border: Border.all(color: cs.outline.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 20).onlyPadding(right: 5),
          Text(title),
          Transform.scale(
            scale: 0.9,
            child: Switch(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
