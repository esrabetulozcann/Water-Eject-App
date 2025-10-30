import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/enum/stereo_channel_enum.dart';
import 'package:water_eject/app/features/data/stereo/stereo_player.dart';
import 'stereo_state.dart';

class StereoCubit extends Cubit<StereoState> {
  final StereoPlayer player;
  Timer? _loop;

  StereoCubit(this.player) : super(StereoState.initial());

  void toggleAutoLoop(bool value) => emit(state.copyWith(autoLoop: value));

  Future<void> tapLeft() async =>
      emit(state.copyWith(selected: StereoChannel.left));
  Future<void> tapRight() async =>
      emit(state.copyWith(selected: StereoChannel.right));

  Future<void> startOrStop() async => state.isTesting ? stop() : start();

  Future<void> start() async {
    if (state.isTesting) return;
    emit(state.copyWith(isTesting: true));

    if (state.autoLoop) {
      _startLoop();
    } else {
      final sel = state.selected == StereoChannel.none
          ? StereoChannel.left
          : state.selected;
      await player.play(sel);
      emit(state.copyWith(active: sel));
    }
  }

  Future<void> stop() async {
    if (!state.isTesting) return;
    _loop?.cancel();
    _loop = null;
    await player.stop();
    emit(state.copyWith(isTesting: false, active: StereoChannel.none));
  }

  void _startLoop() {
    _loop?.cancel();
    StereoChannel next = (state.selected == StereoChannel.none)
        ? StereoChannel.left
        : state.selected;

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
