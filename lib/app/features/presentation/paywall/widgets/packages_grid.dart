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
                    title: LocaleKeys.monthly_title.tr(),
                    price: LocaleKeys.monthly_price2.tr(),
                    period: LocaleKeys.monthly_period.tr(),
                    packageType: LocaleKeys.monthly_title.tr(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: PackageCard(
                    title: LocaleKeys.yearly_title.tr(),
                    price: LocaleKeys.yearly_price.tr(),
                    period: LocaleKeys.yearly_period.tr(),
                    packageType: LocaleKeys.yearly_title.tr(),
                    discount: LocaleKeys.yearly_discount.tr(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Tasarruf banner'ı
            SavingsBanner(
              isVisible: selectedPackage == LocaleKeys.yearly_title.tr(),
            ),
          ],
        );
      },
    );
  }
}
