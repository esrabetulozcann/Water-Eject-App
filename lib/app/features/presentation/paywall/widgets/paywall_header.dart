import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
            icon: const Icon(Icons.close, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(maxWidth: 40),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),

        const SizedBox(height: 8),
        // Başlık
        Text(
          'upgrade_to_premium'.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            // HeadlineSmall -> TitleLarge
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 4),
        // Açıklama
        Text(
          'premium_description'.tr(),
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
