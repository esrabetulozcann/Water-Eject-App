import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/stereo_cubit.dart';
import '../cubit/stereo_state.dart';

class AutoLoopSwitch extends StatelessWidget {
  const AutoLoopSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.refresh_rounded),
          const SizedBox(width: 12),
          Expanded(
            child: Text("auto_loop".tr(), style: theme.textTheme.titleMedium),
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
    );
  }
}
