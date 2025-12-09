import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';
import 'package:water_eject/core/localization/locale_keys.g.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) => p.running != c.running,
      builder: (context, state) {
        return Column(
          children: [
            IconButton.filled(
              onPressed: state.running
                  ? context.read<CleanerCubit>().stop
                  : context.read<CleanerCubit>().start,
              iconSize: 64,
              icon: Icon(
                state.running ? AppIcons.stop.iconData : AppIcons.play.iconData,
              ),
            ).onlyPadding(bottom: 4),
            Text(
              state.running ? LocaleKeys.running.tr() : LocaleKeys.ready.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ).onlyPadding(bottom: 4),
            Text(
              LocaleKeys.ready_hint.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );
      },
    );
  }
}
