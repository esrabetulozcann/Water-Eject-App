import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/common/enum/intensity_enum.dart';
import '../cubit/cleaner_cubit.dart';

class IntensitySelector extends StatelessWidget {
  const IntensitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) => p.intensity != c.intensity || p.running != c.running,
      builder: (context, state) {
        final cubit = context.read<CleanerCubit>();

        final labelStyle = Theme.of(context).textTheme.labelLarge;

        ButtonStyle segmentedStyle = ButtonStyle(
          // Seçim durumuna göre arka plan/kenar/foreground
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.12);
            }
            return AppColors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary;
            }
            return Theme.of(context).colorScheme.onSurface;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            final color = states.contains(WidgetState.selected)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor;
            return BorderSide(color: color, width: 1);
          }),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          ),
        );

        Widget segLabel(String text) => Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: labelStyle,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.intensity.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 6),

            SizedBox(
              width: double.infinity,
              child: SegmentedButton<Intensity>(
                showSelectedIcon: false,
                style: segmentedStyle,
                segments: [
                  ButtonSegment(
                    value: Intensity.soft,
                    label: segLabel(LocaleKeys.intensity_soft.tr()),
                  ),
                  ButtonSegment(
                    value: Intensity.medium,
                    label: segLabel(LocaleKeys.intensity_medium.tr()),
                  ),
                  ButtonSegment(
                    value: Intensity.strong,
                    label: segLabel(LocaleKeys.intensity_strong.tr()),
                  ),
                ],
                selected: {state.intensity},
                onSelectionChanged: state.running
                    ? null
                    : (set) => cubit.setIntensity(set.first),
              ),
            ),
          ],
        );
      },
    );
  }
}
