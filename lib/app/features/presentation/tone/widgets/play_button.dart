import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
            label: Text(isPlaying ? "stop".tr() : "play".tr()),
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
