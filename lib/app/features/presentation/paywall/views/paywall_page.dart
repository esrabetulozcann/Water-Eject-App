import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/core/di/locator.dart';
import '../cubit/paywall_selection_cubit.dart';
import '../widgets/paywall_header.dart';
import '../widgets/features_list.dart';
import '../widgets/packages_grid.dart';
import '../widgets/pay_button.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  static Future<bool?> show(BuildContext context) async {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PaywallPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<PaywallSelectionCubit>()),
      ], // create: (_) => PaywallSelectionCubit()
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.80,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PaywallHeader(),
              const SizedBox(height: 12),
              const FeaturesList(),
              const SizedBox(height: 12),
              const PackagesGrid(),
              const SizedBox(height: 12),
              const PayButton(),
              const SizedBox(height: 8),
              // const TrustFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
