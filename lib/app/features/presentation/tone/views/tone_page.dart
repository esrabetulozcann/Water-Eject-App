import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/data/cleaner/audio/just_audio_engine.dart';
import 'package:water_eject/app/features/data/tone/tone_player.dart';
import 'package:water_eject/app/features/presentation/tone/widgets/tone_app_bar.dart';
import '../cubit/tone_cubit.dart';
import 'tone_view.dart';

class TonePage extends StatelessWidget {
  const TonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToneCubit>(
      create: (_) => ToneCubit(TonePlayer(JustAudioEngine())),
      child: Scaffold(
        appBar: ToneAppBar(),
        body: Padding(padding: EdgeInsets.all(16), child: const ToneView()),
      ),
    );
  }
}
