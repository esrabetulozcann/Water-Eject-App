import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/paywall_selection_cubit.dart';
import '../cubit/premium_cubit.dart';

class PayButton extends StatelessWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocBuilder<PaywallSelectionCubit, String>(
      builder: (context, selectedPackage) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => _onPayPressed(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              selectedPackage == LocaleKeys.yearly_title.tr()
                  ? LocaleKeys.pay_yearly.tr()
                  : LocaleKeys.pay_monthly.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPayPressed(BuildContext context) async {
    try {
      final premiumCubit = context.read<PremiumCubit>();
      await premiumCubit.activatePremium();
      Navigator.of(context).pop(true);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.premium_activated.tr()),
            backgroundColor: Theme.of(context).colorScheme.primary,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.error.tr(args: ['$e'])),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }
}
