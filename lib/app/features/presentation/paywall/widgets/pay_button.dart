import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/enum/paywall_plan_type_enum.dart';
import '../cubit/paywall_selection_cubit.dart';
import '../cubit/premium_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class PayButton extends StatelessWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<PaywallSelectionCubit, PlanType>(
      builder: (context, selected) {
        final text = selected == PlanType.yearly
            ? LocaleKeys.payYearly
                  .tr() // “Pay ₺99.99”
            : LocaleKeys.payMonthly.tr(); // “Pay ₺19.99”

        return SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _onPayPressed(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onPayPressed(BuildContext context) async {
    final premiumCubit = context.read<PremiumCubit>();
    try {
      await premiumCubit.activatePremium();
      if (!context.mounted) return;
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(LocaleKeys.premiumActivated.tr())));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.error.tr(args: ['$e']))),
      );
    }
  }
}
