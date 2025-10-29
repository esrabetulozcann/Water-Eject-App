import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class InfoRow extends StatelessWidget {
  final String currentText;
  final String peakText;
  final VoidCallback onResetPeak;

  const InfoRow({
    super.key,
    required this.currentText,
    required this.peakText,
    required this.onResetPeak,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _InfoTile(
              title: LocaleKeys.currentDb.tr(),
              value: currentText,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _InfoTile(
              title: LocaleKeys.peakDb.tr(),
              value: peakText,
              action: TextButton(
                onPressed: onResetPeak,
                child: Text(LocaleKeys.reset.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final Widget? action;

  const _InfoTile({required this.title, required this.value, this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
