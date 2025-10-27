import 'dart:async';

import 'dart:math' as math;
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:water_eject/app/domain/models/buble_model.dart';
import 'package:water_eject/app/domain/services/audio_engine_service.dart';
import 'package:water_eject/app/domain/services/vibration_service.dart';
import 'package:water_eject/app/features/data/cleaner/audio/tone_generator.dart';

import 'cleaner_state.dart';
import '../../../../common/enum/cleaner_mode_enum.dart';
import '../../../../common/enum/intensity_enum.dart';

class CleanerCubit extends Cubit<CleanerState> {
  final IAudioEngine audio;
  final IVibrationService vibration;
  final VolumeController _volume;

  CleanerCubit({
    required this.audio,
    required this.vibration,
    VolumeController? volumeController,
  }) : _volume = volumeController ?? VolumeController.instance,
       super(const CleanerState());

  double? _oldVolume;
  Timer? _timer;
  Timer? _vibTimer;
  Timer? _bubbleTimer;

  void _startBubbles() {
    emit(state.copyWith(bubbles: [], showBubbles: true));

    _bubbleTimer?.cancel();
    _bubbleTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!state.running) {
        timer.cancel();
        return;
      }
      final random = math.Random();
      final newBubble = Bubble(
        size: random.nextDouble() * 30 + 20, // 20-50 arası boyut
        left: random.nextDouble() * 300, // 0-300 arası konum
        duration: random.nextInt(2000) + 1000, // 1-3 saniye
        bottom: 0.0,
      );

      final currentBubbles = List<Bubble>.from(state.bubbles);
      if (currentBubbles.length < 15) {
        // Maksimum 15 baloncuk
        currentBubbles.add(newBubble);
        emit(state.copyWith(bubbles: currentBubbles));
      }
    });
  }

  void _stopBubbles() {
    _bubbleTimer?.cancel();
    emit(state.copyWith(showBubbles: false, bubbles: []));
  }

  void _updateBubbles() {
    final updatedBubbles = state.bubbles
        .map((bubble) {
          // Baloncukları yukarı hareket ettir
          final newBottom = bubble.bottom + 50; // Her seferinde 50px yukarı
          return bubble.copyWith(bottom: newBottom);
        })
        .where((bubble) => bubble.bottom < 600)
        .toList(); // 600px'den fazla olanları kaldır

    if (updatedBubbles.length != state.bubbles.length) {
      emit(state.copyWith(bubbles: updatedBubbles));
    }
  }

  void _log(String m, [Object? d]) {
    if (kDebugMode)
      dev.log(
        '${DateTime.now().toIso8601String()} $m ${d ?? ''}',
        name: 'Cleaner',
      );
  }

  // ---- intentler
  Future<void> setMode(CleanerMode mode) async =>
      emit(state.copyWith(mode: mode));
  Future<void> setIntensity(Intensity i) async =>
      emit(state.copyWith(intensity: i));
  Future<void> setDuration(int sec) async =>
      emit(state.copyWith(durationSec: sec, remainingSec: sec));
  Future<void> setFrequency(double hz) async =>
      emit(state.copyWith(frequencyHz: hz, currentHz: hz));
  Future<void> setVibrationEnabled(bool v) async =>
      emit(state.copyWith(vibrationEnabled: v));

  ({
    double startHz,
    double endHz,
    double toneVolume,
    double tremoloRate,
    double tremoloDepth,
    double vibratoRate,
    double vibratoDepthCents,
    double h2,
    double h3,
    double noiseMix,
    double attackMs,
    double releaseMs,
  })
  _profile() {
    switch (state.intensity) {
      case Intensity.soft:
        return (
          startHz: 160,
          endHz: 220,
          toneVolume: 0.65,
          tremoloRate: 3.0,
          tremoloDepth: 0.15,
          vibratoRate: 5.0,
          vibratoDepthCents: 5.0,
          h2: 0.05,
          h3: 0.0,
          noiseMix: 0.00,
          attackMs: 12,
          releaseMs: 12,
        );
      case Intensity.medium:
        return (
          startHz: 140,
          endHz: 260,
          toneVolume: 0.85,
          tremoloRate: 4.0,
          tremoloDepth: 0.25,
          vibratoRate: 5.5,
          vibratoDepthCents: 8.0,
          h2: 0.10,
          h3: 0.04,
          noiseMix: 0.01,
          attackMs: 10,
          releaseMs: 10,
        );
      case Intensity.strong:
        return (
          startHz: 130,
          endHz: 300,
          toneVolume: 1.00,
          tremoloRate: 5.0,
          tremoloDepth: 0.35,
          vibratoRate: 6.0,
          vibratoDepthCents: 12.0,
          h2: 0.18,
          h3: 0.08,
          noiseMix: 0.02,
          attackMs: 8,
          releaseMs: 8,
        );
    }
  }

  double _instantHzLogSweep(double s, double e, int T, int t) {
    final K = T / math.log(e / s);
    return (s * math.exp(t / K)).clamp(s, e);
  }

  Future<void> start() async {
    if (state.running) return;

    final prof = _profile();
    final initialHz = state.mode == CleanerMode.sweep
        ? prof.startHz
        : state.frequencyHz;

    emit(
      state.copyWith(
        running: true,
        progress: 0,
        error: null,
        remainingSec: state.durationSec,
        currentHz: initialHz,
        showBubbles: true,
        bubbles: [],
      ),
    );

    try {
      //Baloncukları başlattım
      /* _startBubbles();

      // Baloncuk güncellemeleri
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (!state.running) {
          timer.cancel();
          return;
        }
        _updateBubbles();
      });
*/
      _oldVolume = await _volume.getVolume();
      await _volume.setVolume(1.0);
      await WakelockPlus.enable();
      _log('START', {
        'mode': state.mode.name,
        'intensity': state.intensity.name,
      });

      // audio bytes
      final prof = _profile();

      final bytes = state.mode == CleanerMode.sweep
          ? ToneGenerator.richLogSweepWav(
              startHz: prof.startHz,
              endHz: prof.endHz,
              durationMs: state.durationSec * 1000,
              volume: prof.toneVolume,
              tremoloRateHz: prof.tremoloRate,
              tremoloDepth: prof.tremoloDepth,
              h2: prof.h2,
              h3: prof.h3,
              noiseMix: prof.noiseMix,
              attackMs: prof.attackMs,
              releaseMs: prof.releaseMs,
            )
          : ToneGenerator.richToneWav(
              baseHz: state.frequencyHz,
              durationMs: state.durationSec * 1000,
              volume: prof.toneVolume,
              vibratoRateHz: prof.vibratoRate,
              vibratoDepthCents: prof.vibratoDepthCents,
              tremoloRateHz: prof.tremoloRate,
              tremoloDepth: prof.tremoloDepth,
              h2: prof.h2,
              h3: prof.h3,
              noiseMix: prof.noiseMix,
              attackMs: prof.attackMs,
              releaseMs: prof.releaseMs,
            );

      await audio.prepareFromBytes(bytes);
      audio.playerState$.listen(
        (s) => _log('player', {'playing': s.playing, 'proc': s.processing}),
      );

      // await audio.play();

      // vibration
      if (state.vibrationEnabled) {
        if (await vibration.isSupported()) {
          final amp = switch (state.intensity) {
            Intensity.soft => 30,
            Intensity.medium => 100,
            Intensity.strong => 180,
          };
          _vibTimer?.cancel();
          _vibTimer = Timer.periodic(const Duration(milliseconds: 300), (_) {
            vibration.vibrate(durationMs: 120, amplitude: amp);
          });
          _log('vibration ON', {'amp': amp});
        } else {
          _log('vibration NOT supported');
        }
      } else {
        _log('vibration disabled');
      }

      // timer
      final total = state.durationSec;
      var elapsed = 0;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsed++;
        final remaining = (total - elapsed).clamp(0, total);
        final prog = (elapsed / total).clamp(0.0, 1.0);
        final hz = state.mode == CleanerMode.sweep
            ? _instantHzLogSweep(prof.startHz, prof.endHz, total, elapsed)
            : state.frequencyHz;

        emit(
          state.copyWith(
            progress: prog,
            remainingSec: remaining,
            currentHz: hz,
          ),
        );
        _log('tick', {'remaining': remaining, 'hz': hz.toStringAsFixed(1)});

        if (elapsed >= total) stop();
      });

      audio.play();
    } catch (e) {
      _log('ERROR', e.toString());
      emit(
        state.copyWith(
          running: false,
          progress: 0,
          error: e.toString(),
          showBubbles: false,
        ),
      );
      await _cleanup();
    }
  }

  Future<void> stop() async {
    if (!state.running) return;
    _log('STOP');
    await audio.stop();
    _stopBubbles();
    await _cleanup();
    final prof = _profile();
    emit(
      state.copyWith(
        running: false,
        progress: 1.0,
        remainingSec: state.durationSec,
        currentHz: state.mode == CleanerMode.sweep
            ? prof.startHz
            : state.frequencyHz,
        showBubbles: false, // baloncukları gizledim
      ),
    );
  }

  Future<void> _cleanup() async {
    _bubbleTimer?.cancel();
    _bubbleTimer = null;
    _timer?.cancel();
    _timer = null;
    _vibTimer?.cancel();
    _vibTimer = null;
    await vibration.cancel();
    await WakelockPlus.disable();
    if (_oldVolume != null) {
      await _volume.setVolume(_oldVolume!.clamp(0.0, 1.0));
    }
    _log('cleanup');
  }

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }
}
