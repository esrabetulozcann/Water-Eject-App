import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;
  final String? title; // istersen başlık gösterebilirsin

  const SettingsSection({super.key, required this.children, this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceVariant,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title!, style: theme.textTheme.titleMedium),
                ),
              ),
              const Divider(height: 8),
            ],
            ..._withDividers(children, theme),
          ],
        ),
      ),
    );
  }

  List<Widget> _withDividers(List<Widget> items, ThemeData theme) {
    final out = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      out.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: items[i],
        ),
      );
      if (i != items.length - 1) {
        out.add(Divider(height: 1, color: theme.dividerColor.withOpacity(0.2)));
      }
    }
    return out;
  }
}
