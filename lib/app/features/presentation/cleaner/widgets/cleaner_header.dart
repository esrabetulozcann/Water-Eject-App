import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                'app_title'.tr(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'cta_subtitle'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => showAboutDialog(
            context: context,
            applicationName: 'app_title'.tr(),
            children: [Text('disclaimer_body'.tr())],
          ),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
