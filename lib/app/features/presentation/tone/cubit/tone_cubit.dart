import 'package:flutter_bloc/flutter_bloc.dart';
import 'tone_state.dart';
import 'package:water_eject/app/features/data/tone/tone_player.dart';

class ToneCubit extends Cubit<ToneState> {
  final TonePlayer player;

  ToneCubit(this.player) : super(ToneState.initial());

  static const _throttleMs = 16; // ~60 fps
  static const _step = 1.0; // 1 Hz aralık
  DateTime _lastEmit = DateTime.fromMillisecondsSinceEpoch(0);

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
    // yakın değerse boşuna redraw yapmayalım
    if ((clamped - state.freq).abs() < 0.001) return;

    if (state.isPlaying) {
      await player.setFrequency(clamped);
    }
    emit(state.copyWith(freq: clamped, prevFreq: state.freq));
  }

  Future<void> setPreset(double hz) => setFreq(hz);

  Future<void> onVerticalDrag(double dy) async {
    const sensitivity = 0.4; // daha kontrollü
    final raw = state.freq + (-dy * sensitivity);
    final clamped = raw.clamp(state.minHz, state.maxHz).toDouble();
    final snapped = (clamped / _step).roundToDouble() * _step;

    final now = DateTime.now();
    final tooSoon = now.difference(_lastEmit).inMilliseconds < _throttleMs;
    final tooSmall = (snapped - state.freq).abs() < _step;

    if (tooSoon || tooSmall) return;

    _lastEmit = now;
    await setFreq(snapped);
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
