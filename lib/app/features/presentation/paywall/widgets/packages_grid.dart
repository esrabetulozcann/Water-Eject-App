import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/paywall_selection_cubit.dart';
import 'package_card.dart';
import 'savings_banner.dart';

class PackagesGrid extends StatelessWidget {
  const PackagesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaywallSelectionCubit, String>(
      builder: (context, selectedPackage) {
        return Column(
          children: [
            // Paket kartları
            Row(
              children: [
                Expanded(
                  child: PackageCard(
                    title: LocaleKeys.monthlyTitle.tr(),
                    price: LocaleKeys.monthlyPrice2.tr(),
                    period: LocaleKeys.monthlyPeriod.tr(),
                    packageType: LocaleKeys.monthlyTitle.tr(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: PackageCard(
                    title: LocaleKeys.yearlyTitle.tr(),
                    price: LocaleKeys.yearlyPrice.tr(),
                    period: LocaleKeys.yearlyPeriod.tr(),
                    packageType: LocaleKeys.yearlyTitle.tr(),
                    discount: LocaleKeys.yearlyDiscount.tr(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Tasarruf banner'ı
            SavingsBanner(
              isVisible: selectedPackage == LocaleKeys.yearlyTitle.tr(),
            ),
          ],
        );
      },
    );
  }
}
