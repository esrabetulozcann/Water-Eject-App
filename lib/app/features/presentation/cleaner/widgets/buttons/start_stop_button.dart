import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) => p.running != c.running,
      builder: (context, state) {
        final cubit = context.read<CleanerCubit>();
        return Column(
          children: [
            IconButton.filled(
              onPressed: state.running ? cubit.stop : cubit.start,
              iconSize: 64,
              icon: Icon(state.running ? Icons.stop : Icons.water_drop),
            ),
            const SizedBox(height: 4),
            Text(
              state.running ? 'running'.tr() : 'ready'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        );
      },
    );
  }
}
