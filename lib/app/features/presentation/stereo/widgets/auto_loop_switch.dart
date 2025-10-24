import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/stereo_cubit.dart';
import '../cubit/stereo_state.dart';

class AutoLoopSwitch extends StatelessWidget {
  const AutoLoopSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(AppIcons.refresh.iconData),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  LocaleKeys.auto_loop.tr(),
                  style: theme.textTheme.titleMedium,
                ),
              ),
              BlocSelector<StereoCubit, StereoState, bool>(
                selector: (s) => s.autoLoop,
                builder: (_, auto) {
                  return Switch(
                    value: auto,
                    onChanged: context.read<StereoCubit>().toggleAutoLoop,
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            LocaleKeys.auto_loop_description.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
