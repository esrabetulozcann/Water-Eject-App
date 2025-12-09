import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class InfoRow extends StatelessWidget {
  final AppIcons icon;
  final String text;

  const InfoRow({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon.iconData,
          color: Theme.of(context).colorScheme.primary,
        ).onlyPadding(right: 10, top: 6),

        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    ).onlyPadding(bottom: 12);
  }
}
