import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

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
        spacing: 8,
        children: [
          Expanded(
            child: _InfoTile(
              title: LocaleKeys.currentDb.tr(),
              value: currentText,
            ),
          ),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ).onlyPadding(bottom: 4),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ).allPadding(16),
    );
  }
}
