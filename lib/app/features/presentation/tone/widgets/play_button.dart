import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/tone_cubit.dart';
import '../cubit/tone_state.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ToneCubit, ToneState, bool>(
      selector: (s) => s.isPlaying,
      builder: (_, isPlaying) {
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            icon: Icon(
              isPlaying ? AppIcons.stop.iconData : AppIcons.playArrow.iconData,
            ),
            label: Text(
              isPlaying ? LocaleKeys.stop.tr() : LocaleKeys.play.tr(),
            ),
            onPressed: () => context.read<ToneCubit>().toggle(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        );
      },
    );
  }
}
