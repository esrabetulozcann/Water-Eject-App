import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:water_eject/app/domain/repositories/sound_level_repository.dart';
import 'dbmeter_state.dart';

class DbMeterCubit extends Cubit<DbMeterState> with WidgetsBindingObserver {
  final SoundLevelRepository repo;
  StreamSubscription? _levelSub;

  DbMeterCubit(this.repo) : super(DbMeterState.initial()) {
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> init() async {
    await checkPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      stop();
    }
  }

  Future<void> checkPermission() async {
    final status = await Permission.microphone.status;
    emit(state.copyWith(permission: _map(status), effect: null));
  }

  Future<void> requestPermission() async {
    final result = await Permission.microphone.request();
    emit(state.copyWith(permission: _map(result), effect: null));
  }

  MicPermissionStatus _map(PermissionStatus s) {
    if (s.isGranted) return MicPermissionStatus.granted;
    if (s.isPermanentlyDenied) return MicPermissionStatus.permanentlyDenied;
    if (s.isDenied || s.isRestricted) return MicPermissionStatus.denied;
    return MicPermissionStatus.unknown;
  }

  /// Start/Stop butonuna basıldığında yalnızca bu çağrılsın dedim
  Future<void> handleStartStopPressed() async {
    if (state.isMeasuring) {
      await stop();
      return;
    }
    if (state.permission == MicPermissionStatus.granted) {
      await start();
      return;
    }
    final permanentlyDenied =
        state.permission == MicPermissionStatus.permanentlyDenied;
    emit(state.copyWith(effect: ShowPermissionDialog(permanentlyDenied)));
  }

  /// Dialogdan sonra UI tarafından çağrılır.
  Future<void> requestPermissionAndStart({
    required bool permanentlyDenied,
  }) async {
    clearEffect();

    if (permanentlyDenied) {
      await openAppSettings();
      await checkPermission();
    } else {
      await requestPermission();
    }

    if (state.permission == MicPermissionStatus.granted) {
      await start();
    }
  }

  void clearEffect() {
    if (state.effect != null) {
      emit(state.copyWith(effect: null));
    }
  }

  Future<void> start() async {
    if (state.isMeasuring) return;

    if (state.permission != MicPermissionStatus.granted) {
      await requestPermission();
      if (state.permission != MicPermissionStatus.granted) return;
    }

    await repo.start();
    await _levelSub?.cancel();

    _levelSub = repo.levels.listen(
      (level) {
        emit(
          state.copyWith(
            isMeasuring: true,
            currentDb: level.db,
            peakDb: level.peakDb,
            effect: null,
          ),
        );
      },
      onError: (_) {
        emit(state.copyWith(isMeasuring: false, effect: null));
      },
    );

    emit(state.copyWith(isMeasuring: true, effect: null));
  }

  Future<void> stop() async {
    await repo.stop();
    await _levelSub?.cancel();
    _levelSub = null;
    emit(state.copyWith(isMeasuring: false, effect: null, currentDb: 0));
  }

  void resetPeak() {
    repo.resetPeak();
    emit(state.copyWith(peakDb: 0, effect: null));
  }

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    await _levelSub?.cancel();
    return super.close();
  }
}
