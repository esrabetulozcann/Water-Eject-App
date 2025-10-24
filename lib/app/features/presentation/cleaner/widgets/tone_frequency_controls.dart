import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/common/enum/cleaner_mode_enum.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import '../cubit/cleaner_cubit.dart';

class ToneFrequencyControls extends StatelessWidget {
  const ToneFrequencyControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) =>
          p.mode != c.mode ||
          p.frequencyHz != c.frequencyHz ||
          p.running != c.running,
      builder: (context, state) {
        if (state.mode != CleanerMode.tone) return const SizedBox.shrink();

        final cubit = context.read<CleanerCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.frequency.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              min: 120,
              max: 350,
              divisions: 230,
              value: state.frequencyHz,
              onChanged: state.running ? null : cubit.setFrequency,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                LocaleKeys.hz_fmt.tr(
                  args: [state.frequencyHz.toStringAsFixed(0)],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
