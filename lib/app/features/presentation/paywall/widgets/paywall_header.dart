import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class PaywallHeader extends StatelessWidget {
  const PaywallHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        // Kapatma butonu
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(AppIcons.close.iconData, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(maxWidth: 40),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),

        const SizedBox(height: 8),
        // Başlık
        Text(
          LocaleKeys.upgradeToPremium.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            // HeadlineSmall -> TitleLarge
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 4),
        // Açıklama
        Text(
          LocaleKeys.premiumDescription.tr(),
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
