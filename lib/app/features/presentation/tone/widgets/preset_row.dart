import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';
import '../cubit/tone_cubit.dart';
import '../cubit/tone_state.dart';

class PresetRow extends StatelessWidget {
  const PresetRow({super.key, required this.presets});
  final List<double> presets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToneCubit, ToneState>(
      buildWhen: (p, c) => p.freq != c.freq,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: presets.map((p) {
            final isActive = (state.freq.round() == p.round());
            return _PresetChip(
              labelTop: "${p.toStringAsFixed(0)} Hz",
              labelBottom: _labelOf(p),
              active: isActive,
              onTap: () => context.read<ToneCubit>().setPreset(p),
            );
          }).toList(),
        );
      },
    );
  }

  String _labelOf(double p) {
    if (p <= 70) return LocaleKeys.presetDeepBass.tr();
    if (p <= 110) return LocaleKeys.presetStrongBass.tr();
    return LocaleKeys.presetLight.tr();
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
    required this.labelTop,
    required this.labelBottom,
    required this.active,
    required this.onTap,
  });

  final String labelTop;
  final String labelBottom;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    //final base = theme.colorScheme.primary.withOpacity(0.10);

    final activeBg = Theme.of(context).colorScheme.primary.withOpacity(0.08);
    final inactiveBg = Theme.of(context).colorScheme.primary.withOpacity(0.04);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        // width: 110,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: active ? activeBg : inactiveBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active
                ? Theme.of(context).colorScheme.primary
                : AppColors.transparent,
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              labelTop,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
            ).onlyPadding(bottom: 4),
            Text(
              labelBottom,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                letterSpacing: 0.5,
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ).onlyPadding(right: 12, left: 0, bottom: 0, top: 0),
    );
  }
}
