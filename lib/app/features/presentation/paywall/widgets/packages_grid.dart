import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/enum/paywall_plan_type_enum.dart';
import '../cubit/paywall_selection_cubit.dart';
import 'package_card.dart';
import 'savings_banner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class PackagesGrid extends StatelessWidget {
  const PackagesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaywallSelectionCubit, PlanType>(
      builder: (context, selected) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: PackageCard(
                    type: PlanType.monthly,
                    title: LocaleKeys.monthlyTitle.tr(),
                    period: '/${LocaleKeys.payMonthly.tr()}',
                    // fiyatları kart içinde
                    currency: '₺',
                    major: 19,
                    minor: 99,
                    // rozet yok ama yer ayrılacak Opacity ile
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PackageCard(
                    type: PlanType.yearly,
                    title: LocaleKeys.yearlyTitle.tr(),
                    period: '/${LocaleKeys.year.tr()}',
                    currency: '₺',
                    major: 99,
                    minor: 99,
                    badgeText: LocaleKeys.yearlyDiscount.tr(),
                    monthlyNote: LocaleKeys.yearlyPrice.tr(args: ['₺8.33']),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Banner alanı sabit kalsın
            SavingsBanner(
              visible: selected == PlanType.yearly,
              text:
                  '${LocaleKeys.savingsBannerPart1.tr()} '
                  '${LocaleKeys.savingsBannerPart2.tr()} '
                  '${LocaleKeys.savingsBannerPart3.tr()}',
            ),
          ],
        );
      },
    );
  }
}
