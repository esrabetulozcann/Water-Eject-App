import 'package:flutter_bloc/flutter_bloc.dart';
import 'tone_state.dart';
import 'package:water_eject/app/features/data/tone/tone_player.dart';

class ToneCubit extends Cubit<ToneState> {
  final TonePlayer player;

  ToneCubit(this.player) : super(ToneState.initial());

  Future<void> toggle() async {
    if (state.isPlaying) {
      emit(state.copyWith(isPlaying: false));
      try {
        await player.stop();
      } catch (_) {
        emit(state.copyWith(isPlaying: true));
      }
    } else {
      emit(state.copyWith(isPlaying: true));
      try {
        await player.start(state.freq);
      } catch (_) {
        emit(state.copyWith(isPlaying: false));
      }
    }
  }

  Future<void> setFreq(double hz) async {
    final clamped = hz.clamp(state.minHz, state.maxHz).toDouble();
    if (state.isPlaying) {
      await player.setFrequency(clamped);
    }
    emit(state.copyWith(freq: clamped, prevFreq: state.freq));
  }

  Future<void> setPreset(double hz) => setFreq(hz);

  Future<void> onVerticalDrag(double dy) async {
    const sensitivity = 0.5; // 1px ≈ 0.5 Hz
    final next = state.freq + (-dy * sensitivity);
    await setFreq(next);
  }

  Future<void> stop() async {
    emit(state.copyWith(isPlaying: false));
    try {
      await player.stop();
    } catch (_) {
      // hata durumunda UI güncellemesi yapılmaz
    }
  }

  @override
  Future<void> close() async {
    await player.dispose();
    return super.close();
  }
}
