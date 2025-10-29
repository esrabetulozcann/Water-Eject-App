import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class CleanerHeader extends StatelessWidget {
  const CleanerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.appTitle.tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                LocaleKeys.ctaSubtitle.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => showAboutDialog(
            context: context,
            applicationName: LocaleKeys.appTitle.tr(),
            children: [Text(LocaleKeys.disclaimerBody.tr())],
          ),
          icon: Icon(AppIcons.settings.iconData),
        ),
      ],
    );
  }
}
