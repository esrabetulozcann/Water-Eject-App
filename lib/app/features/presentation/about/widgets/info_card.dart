import 'package:flutter/material.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget>? children;

  const InfoCard({
    super.key,
    required this.title,
    this.description,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ).onlyPadding(bottom: 12),

          if (description != null)
            Text(description!, style: Theme.of(context).textTheme.bodyMedium),

          if (children != null) ...[const SizedBox(height: 12), ...children!],
        ],
      ),
    );
  }
}
