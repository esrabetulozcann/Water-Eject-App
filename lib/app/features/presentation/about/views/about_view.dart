import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/widgets/common_app_bar.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';
import '../widgets/about_header.dart';
import '../widgets/info_card.dart';
import '../widgets/info_row.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: LocaleKeys.aboutTitle.tr(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AboutHeader().onlyPadding(bottom: 32),

            InfoCard(
              title: LocaleKeys.waterEjectWhatsThis.tr(),
              description: LocaleKeys.waterEjectWhatsThisDesc.tr(),
            ).onlyPadding(bottom: 20),

            InfoCard(
              title: LocaleKeys.waterEjectHowToUse.tr(),
              children: [
                InfoRow(
                  text: LocaleKeys.waterEjectHz.tr(),
                  icon: AppIcons.graphicEq,
                ),
                InfoRow(
                  text: LocaleKeys.waterEjectVibration.tr(),
                  icon: AppIcons.vibration,
                ),
                InfoRow(
                  text: LocaleKeys.waterEjectEjectsWater.tr(),
                  icon: AppIcons.waterDrop,
                ),
              ],
            ).onlyPadding(bottom: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    AppIcons.info.iconData,
                    color: Theme.of(context).colorScheme.primary,
                  ).onlyPadding(right: 12),
                  Expanded(
                    child: Text(
                      LocaleKeys.waterEjectAboutNote.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
