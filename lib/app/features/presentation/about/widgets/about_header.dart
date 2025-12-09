import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
          ),
          child: Icon(
            AppIcons.waterDrop.iconData,
            size: 46,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).onlyPadding(bottom: 16),

        Text(
          LocaleKeys.appTitle.tr(),
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ).onlyPadding(bottom: 4),

        Text(
          "Version 1.0.0",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
