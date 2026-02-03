import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';
import '../cubit/stereo_cubit.dart';
import '../cubit/stereo_state.dart';

class AutoLoopSwitch extends StatelessWidget {
  const AutoLoopSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(AppIcons.refresh.iconData).onlyPadding(right: 12),
              Expanded(
                child: Text(
                  LocaleKeys.autoLoop.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
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
          Text(
            LocaleKeys.autoLoopDescription.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.start,
          ).onlyPadding(top: 8),
        ],
      ),
    );
  }
}
