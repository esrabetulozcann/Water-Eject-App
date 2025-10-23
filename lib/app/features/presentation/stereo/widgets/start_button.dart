import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/stereo_cubit.dart';
import '../cubit/stereo_state.dart';

import 'package:water_eject/app/features/presentation/paywall/cubit/premium_cubit.dart';
import 'package:water_eject/app/features/presentation/paywall/views/paywall_page.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StereoCubit, StereoState>(
      buildWhen: (p, c) => p.isTesting != c.isTesting,
      builder: (_, state) {
        final isOn = state.isTesting;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
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
            icon: Icon(isOn ? Icons.stop_rounded : Icons.play_arrow_rounded),
            label: Text(isOn ? 'stop'.tr() : 'start'.tr()),
          ),
        );
      },
    );
  }
}
