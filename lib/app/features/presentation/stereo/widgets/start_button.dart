import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/stereo_cubit.dart';
import '../cubit/stereo_state.dart';

import 'package:water_eject/app/features/presentation/paywall/cubit/premium_cubit.dart';
import 'package:water_eject/app/features/presentation/paywall/views/paywall_page.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocBuilder<StereoCubit, StereoState>(
      buildWhen: (p, c) => p.isTesting != c.isTesting,
      builder: (_, state) {
        final isOn = state.isTesting;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () async {
              final isPremium = context.read<PremiumCubit>().state;

              if (!isPremium && !isOn) {
                final purchased = await PaywallPage.show(context) ?? false;
                if (!purchased) return;
              }

              await context.read<StereoCubit>().startOrStop();
            },
            icon: Icon(
              isOn
                  ? AppIcons.stopRounded.iconData
                  : AppIcons.playArrowRounded.iconData,
              size: isOn ? 20 : 24,
            ),
            label: Text(
              isOn ? LocaleKeys.stop.tr() : LocaleKeys.start.tr(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
