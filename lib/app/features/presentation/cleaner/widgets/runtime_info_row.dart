import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import '../cubit/cleaner_cubit.dart';

class RuntimeInfoRow extends StatelessWidget {
  const RuntimeInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) =>
          p.remainingSec != c.remainingSec || p.currentHz != c.currentHz,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppIcons.time.iconData, size: 18),
            const SizedBox(width: 6),
            Text(LocaleKeys.seconds_fmt.tr(args: ['${state.remainingSec}'])),
            const SizedBox(width: 12),
            Icon(AppIcons.graphicEq.iconData, size: 18),
            const SizedBox(width: 6),
            Text(
              LocaleKeys.hz_fmt.tr(args: [state.currentHz.toStringAsFixed(0)]),
            ),
          ],
        );
      },
    );
  }
}
