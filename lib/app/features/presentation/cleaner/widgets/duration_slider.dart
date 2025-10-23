import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';

class DurationSlider extends StatelessWidget {
  const DurationSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) =>
          p.durationSec != c.durationSec || p.running != c.running,
      builder: (context, state) {
        final cubit = context.read<CleanerCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'duration'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Slider(
              min: 10,
              max: 60,
              divisions: 5,
              value: state.durationSec.toDouble(),
              onChanged: state.running
                  ? null
                  : (v) => cubit.setDuration(v.round()),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('seconds_fmt'.tr(args: ['${state.durationSec}'])),
            ),
          ],
        );
      },
    );
  }
}
