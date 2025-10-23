import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
            child: _InfoTile(title: "current_db".tr(), value: currentText),
          ),
          Expanded(
            child: _InfoTile(
              title: "peak_db".tr(),
              value: peakText,
              action: TextButton(
                onPressed: onResetPeak,
                child: Text("reset".tr()),
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
      child: ListTile(
        title: Text(title),
        subtitle: Text(value, style: Theme.of(context).textTheme.titleMedium),
        trailing: action,
      ),
    );
  }
}
