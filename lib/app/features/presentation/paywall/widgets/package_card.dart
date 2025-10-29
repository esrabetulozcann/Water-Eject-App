import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/paywall_selection_cubit.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String packageType;
  final String? discount;

  const PackageCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.packageType,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocBuilder<PaywallSelectionCubit, String>(
      builder: (context, selectedPackage) {
        final isSelected = selectedPackage == packageType;

        return GestureDetector(
          onTap: () {
            context.read<PaywallSelectionCubit>().selectPackage(packageType);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primary.withOpacity(0.1)
                  : colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? colors.primary
                    : colors.outline.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // İndirim etiketi
                if (discount != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      discount!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 16),

                const SizedBox(height: 6),
                // Paket adı
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? colors.primary : colors.onSurface,
                  ),
                ),

                const SizedBox(height: 4),
                // Fiyat
                Text(
                  price,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? colors.primary : colors.onSurface,
                  ),
                ),

                // Periyot
                Text(
                  '/$period',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 4),
                // Aylık maliyet (sadece yıllık için)
                if (period == LocaleKeys.year.tr())
                  Text(
                    LocaleKeys.monthlyPrice.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
