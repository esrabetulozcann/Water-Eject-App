import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/enum/cleaner_mode_enum.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/features/presentation/cleaner/widgets/cards/option_card.dart';
import '../cubit/cleaner_cubit.dart';

class ModeVibrationRow extends StatelessWidget {
  const ModeVibrationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) =>
          p.mode != c.mode ||
          p.vibrationEnabled != c.vibrationEnabled ||
          p.running != c.running,
      builder: (context, state) {
        final cubit = context.read<CleanerCubit>();
        return Row(
          children: [
            Expanded(
              child: OptionCard(
                title: LocaleKeys.sweep.tr(),
                value: state.mode == CleanerMode.sweep,
                icon: AppIcons.waves.iconData,
                onChanged: state.running
                    ? (_) {}
                    : (v) => cubit.setMode(
                        v ? CleanerMode.sweep : CleanerMode.tone,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OptionCard(
                title: LocaleKeys.vibration.tr(),
                value: state.vibrationEnabled,
                icon: AppIcons.vibration.iconData,
                onChanged: state.running
                    ? null
                    : (v) {
                        cubit.setVibrationEnabled(v);
                      },
              ),
            ),
          ],
        );
      },
    );
  }
}
