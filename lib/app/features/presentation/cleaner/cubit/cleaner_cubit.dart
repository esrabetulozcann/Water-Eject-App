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
import 'package:water_eject/app/google_ads.dart';

import 'cleaner_state.dart';
import '../../../../common/enum/cleaner_mode_enum.dart';
import '../../../../common/enum/intensity_enum.dart';

class CleanerCubit extends Cubit<CleanerState> {
  final IAudioEngine audio;
  final IVibrationService vibration;
  final VolumeController _volume;
  final GoogleAds _googleAds = GoogleAds();

  StreamSubscription? _playerSub;

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
  Timer? _bubbleUpdateTimer;
  int _startButtonPressCount = 0;
  bool _isShowingAd = false;

  // Completer: reklam gösterildiğinde start() akışını durdurup reklam kapandığında devam etmek için
  Completer<void>? _adCompleter;

  Future<void> init() async {
    try {
      // Reklamı başta yükle
      await _loadInterstitialAd();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _loadInterstitialAd() async {
    // Her seferinde önce flag temizle
    _isShowingAd = false;

    // GoogleAds.loadInterstitialAd callback'iyle reklam kapandığında
    // completer'ı tamamlayıp yeniden reklam yüklemesi yapacağız.
    _googleAds.loadInterstitialAd(
      showAfterLoad: false,
      onAdDismissed: () {
        // Reklam kapandığında çağrılır
        if (kDebugMode) {
          dev.log('Interstitial dismissed', name: 'Cleaner');
        }
        _isShowingAd = false;

        // Eğer bir bekleyen completer varsa tamamla (start() akışını devam ettir)
        try {
          _adCompleter?.complete();
        } catch (_) {}
        _adCompleter = null;

        // Yeni reklam hazır olsun
        _loadInterstitialAd();
      },
    );
  }

  Future<void> _showInterstitialAd() async {
    // Eğer reklam yüklenmemişse hemen yükle ve geri dön
    if (!_googleAds.isLoaded) {
      if (kDebugMode) {
        dev.log('Ad not loaded, requesting load', name: 'Cleaner');
      }
      await _loadInterstitialAd();
      return;
    }

    if (_isShowingAd) return;

    _isShowingAd = true;
    _adCompleter = Completer<void>();

    // Show - GoogleAds içinde gösterim gerçekleşir, kapandığında onAdDismissed çağrılır
    _googleAds.showInterstitialAd();

    // Reklam kapanana kadar bekle
    try {
      await _adCompleter!.future;
    } catch (_) {
      // ignore
    } finally {
      _adCompleter = null;
      _isShowingAd = false;
    }
  }

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
        size: random.nextDouble() * 30 + 20,
        left: random.nextDouble() * 300,
        duration: random.nextInt(2000) + 1000,
        bottom: 0.0,
      );

      final currentBubbles = List<Bubble>.from(state.bubbles);
      if (currentBubbles.length < 15) {
        currentBubbles.add(newBubble);
        emit(state.copyWith(bubbles: currentBubbles));
      }
    });

    _bubbleUpdateTimer?.cancel();
    _bubbleUpdateTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      if (!state.running) {
        timer.cancel();
        return;
      }
      _updateBubbles();
    });
  }

  void _stopBubbles() {
    _bubbleTimer?.cancel();
    _bubbleTimer = null;
    _bubbleUpdateTimer?.cancel();
    _bubbleUpdateTimer = null;
    emit(state.copyWith(showBubbles: false, bubbles: []));
  }

  void _updateBubbles() {
    final updatedBubbles = state.bubbles
        .map((bubble) {
          final newBottom = bubble.bottom + 50; // yukarı hareket
          return bubble.copyWith(bottom: newBottom);
        })
        .where((bubble) => bubble.bottom < 600) // 600 px üzerini sil
        .toList();

    if (updatedBubbles.length != state.bubbles.length) {
      emit(state.copyWith(bubbles: updatedBubbles));
    }
  }

  // Logging
  void _log(String m, [Object? d]) {
    if (kDebugMode) {
      dev.log(
        '${DateTime.now().toIso8601String()} $m ${d ?? ''}',
        name: 'Cleaner',
      );
    }
  }

  // Setters
  Future<void> setMode(CleanerMode mode) async {
    emit(state.copyWith(mode: mode));
  }

  Future<void> setIntensity(Intensity i) async {
    emit(state.copyWith(intensity: i));
  }

  Future<void> setDuration(int sec) async {
    emit(state.copyWith(durationSec: sec, remainingSec: sec));
  }

  Future<void> setFrequency(double hz) async {
    emit(state.copyWith(frequencyHz: hz, currentHz: hz));
  }

  Future<void> setVibrationEnabled(bool v) async {
    emit(state.copyWith(vibrationEnabled: v));
  }

  // Tone Profile
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
    // defansif: T <= 0 ise başlangıç frekansı dön
    if (T <= 0) return s;
    final K = T / math.log(e / s);
    return (s * math.exp(t / K)).clamp(s, e);
  }

  // Start / Stop
  Future<void> start() async {
    if (state.running || _isShowingAd) return;

    // Reklam kontrolü
    _startButtonPressCount++;

    // İlk açılış veya her 4. tıklamada reklam göster
    if (_startButtonPressCount == 1 || _startButtonPressCount % 4 == 0) {
      // Eğer reklam yüklüyse göster ve reklam bitene kadar bekle
      if (_googleAds.isLoaded) {
        await _showInterstitialAd();
      } else {
        // Yüklü değilse yüklemeyi başlat (kullanıcı deneyimi için start devam edebilir)
        _loadInterstitialAd();
      }

      // eğer reklam gösterildi ise, _showInterstitialAd reklam kapanana kadar bekler
      // ve akış buradan devam eder.
    }

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
      _startBubbles();

      _oldVolume = await _volume.getVolume();
      await _volume.setVolume(1.0);
      await WakelockPlus.enable();
      _log('START', {
        'mode': state.mode.name,
        'intensity': state.intensity.name,
      });

      final prof2 = _profile();

      final bytes = state.mode == CleanerMode.sweep
          ? ToneGenerator.richLogSweepWav(
              startHz: prof2.startHz,
              endHz: prof2.endHz,
              durationMs: state.durationSec * 1000,
              volume: prof2.toneVolume,
              tremoloRateHz: prof2.tremoloRate,
              tremoloDepth: prof2.tremoloDepth,
              h2: prof2.h2,
              h3: prof2.h3,
              noiseMix: prof2.noiseMix,
              attackMs: prof2.attackMs,
              releaseMs: prof2.releaseMs,
            )
          : ToneGenerator.richToneWav(
              baseHz: state.frequencyHz,
              durationMs: state.durationSec * 1000,
              volume: prof2.toneVolume,
              vibratoRateHz: prof2.vibratoRate,
              vibratoDepthCents: prof2.vibratoDepthCents,
              tremoloRateHz: prof2.tremoloRate,
              tremoloDepth: prof2.tremoloDepth,
              h2: prof2.h2,
              h3: prof2.h3,
              noiseMix: prof2.noiseMix,
              attackMs: prof2.attackMs,
              releaseMs: prof2.releaseMs,
            );

      await audio.prepareFromBytes(bytes);

      // Eski dinleyiciyi iptal ettim, yenisini bağladım
      await _playerSub?.cancel();
      _playerSub = audio.playerState$.listen(
        (s) => _log('player', {'playing': s.playing, 'proc': s.processing}),
        onError: (e, _) => _log('player_err', e.toString()),
      );

      //  Vibration
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

      final total = state.durationSec;
      var elapsed = 0;

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsed++;

        final remaining = math.max(0, total - elapsed);
        final prog = (elapsed / total).clamp(0.0, 1.0);

        final hz = state.mode == CleanerMode.sweep
            ? _instantHzLogSweep(prof2.startHz, prof2.endHz, total, elapsed)
            : state.frequencyHz;

        emit(
          state.copyWith(
            progress: prog,
            remainingSec: remaining,
            currentHz: hz,
          ),
        );

        _log('tick', {'remaining': remaining, 'hz': hz.toStringAsFixed(1)});

        if (elapsed >= total) {
          // önce timer’ı durdurdum, sonra stop çağırdım
          _timer?.cancel();
          _timer = null;
          stop();
        }
      });

      await audio.play();
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

    //  Re-entrancy önlemi: timer’ı hemen kes
    _timer?.cancel();
    _timer = null;

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
        showBubbles: false,
      ),
    );
  }

  // Cleanup
  Future<void> _cleanup() async {
    _bubbleTimer?.cancel();
    _bubbleTimer = null;
    _bubbleUpdateTimer?.cancel();
    _bubbleUpdateTimer = null;
    _vibTimer?.cancel();
    _vibTimer = null;

    // Player dinleyicisini kestim
    await _playerSub?.cancel();
    _playerSub = null;

    // Timer zaten stop’ta kesiliyor ama yine defansif:
    _timer?.cancel();
    _timer = null;

    await vibration.cancel();
    await WakelockPlus.disable();

    if (_oldVolume != null) {
      try {
        final vol = _oldVolume!.clamp(0.0, 1.0);
        await _volume.setVolume(vol);
      } catch (_) {
        // sessiz geç
      }
      _oldVolume = null;
    }
    _log('cleanup');
  }

  @override
  Future<void> close() async {
    await _cleanup();
    _googleAds.dispose();
    return super.close();
  }
}
