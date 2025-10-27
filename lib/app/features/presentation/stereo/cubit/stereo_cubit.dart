import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'stereo_state.dart';
import 'package:water_eject/app/features/data/stereo/stereo_player.dart';

class StereoCubit extends Cubit<StereoState> {
  final StereoPlayer player;
  Timer? _loop;

  StereoCubit(this.player) : super(StereoState.initial());

  void toggleAutoLoop(bool value) => emit(state.copyWith(autoLoop: value));

  Future<void> tapLeft() async {
    emit(state.copyWith(selected: StereoChannel.left));
  }

  Future<void> tapRight() async {
    emit(state.copyWith(selected: StereoChannel.right));
  }

  Future<void> startOrStop() async => state.isTesting ? stop() : start();

  Future<void> start() async {
    emit(state.copyWith(isTesting: true));

    if (state.autoLoop) {
      _startLoop(); // sol↔sağ arasında geçiş
    } else {
      //Seçili kanalı kesintisiz çal
      final sel = state.selected == StereoChannel.none
          ? StereoChannel.left
          : state.selected;

      await player.play(sel);
      emit(state.copyWith(active: sel));
    }
  }

  Future<void> stop() async {
    _loop?.cancel();
    _loop = null;
    await player.stop();
    emit(state.copyWith(isTesting: false, active: StereoChannel.none));
  }

  void _startLoop() {
    _loop?.cancel();

    // İlk tur: eğer bir seçim varsa onunla başla, yoksa left
    StereoChannel next = (state.selected == StereoChannel.none)
        ? StereoChannel.left
        : state.selected;

    // Hemen başlat
    _tick(next);
    next = _toggle(next);

    _loop = Timer.periodic(state.stepDuration, (_) {
      _tick(next);
      next = _toggle(next);
    });
  }

  Future<void> _tick(StereoChannel ch) async {
    await player.play(ch);
    emit(state.copyWith(active: ch));
  }

  StereoChannel _toggle(StereoChannel c) =>
      c == StereoChannel.left ? StereoChannel.right : StereoChannel.left;

  @override
  Future<void> close() async {
    _loop?.cancel();
    await player.dispose();
    return super.close();
  }
}
