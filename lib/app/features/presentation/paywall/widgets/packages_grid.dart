import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    title: 'monthly_title'.tr(),
                    price: 'monthly_price2'.tr(),
                    period: 'monthly_period'.tr(),
                    packageType: 'monthly_title'.tr(),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: PackageCard(
                    title: 'yearly_title'.tr(),
                    price: 'yearly_price'.tr(),
                    period: 'yearly_period'.tr(),
                    packageType: 'yearly_title'.tr(),
                    discount: 'yearly_discount'.tr(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Tasarruf banner'ı
            SavingsBanner(isVisible: selectedPackage == 'yearly_title'.tr()),
          ],
        );
      },
    );
  }
}
