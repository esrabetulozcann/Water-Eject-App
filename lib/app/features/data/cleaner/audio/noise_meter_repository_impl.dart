import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:water_eject/app/domain/models/calibration_value.dart';
import 'package:water_eject/app/domain/models/sound_level.dart';
import 'package:water_eject/app/domain/repositories/sound_level_repository.dart';

class NoiseMeterRepositoryImpl implements SoundLevelRepository {
  late final NoiseMeter _noiseMeter;
  StreamSubscription<NoiseReading>? _subscription;

  final StreamController<SoundLevel> _controller =
      StreamController<SoundLevel>.broadcast();

  @override
  Stream<SoundLevel> get levels => _controller.stream;

  double _ema = 0.0; // Exponential Moving Average (dB)
  double _alpha = 0.2; // Smoothing (0-1)
  double _peakDb = 0.0; // Peak dB
  CalibrationValue _calibration = const CalibrationValue(0);

  NoiseMeterRepositoryImpl() {
    _noiseMeter = NoiseMeter(); // parametresiz ctor
  }

  static void _onError(Object e) {
    // burayı yapacağım
  }

  @override
  Future<void> start({
    CalibrationValue calibration = const CalibrationValue(0),
    double smoothingAlpha = 0.2,
  }) async {
    _calibration = calibration;
    _alpha = smoothingAlpha.clamp(0.0, 1.0);
    _ema = 0.0;
    _peakDb = 0.0;

    _subscription = _noiseMeter.noise.listen(
      (reading) {
        // Dokümantasyondaki alan adları:
        // reading.meanDecibel, reading.maxDecibel
        final rawDb = reading.meanDecibel;

        // EMA: ilk örnekle başlat
        _ema = (_ema == 0.0) ? rawDb : (_alpha * rawDb + (1 - _alpha) * _ema);

        final calibrated = _ema + _calibration.offsetDb;
        if (calibrated > _peakDb) _peakDb = calibrated;

        _controller.add(
          SoundLevel(
            db: calibrated,
            peakDb: _peakDb,
            timestamp: DateTime.now(),
          ),
        );
      },
      onError: _onError,
      cancelOnError: true,
    );
  }

  @override
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  @override
  void setCalibration(CalibrationValue calibration) {
    _calibration = calibration;
  }

  @override
  void setSmoothing(double alpha) {
    _alpha = alpha.clamp(0.0, 1.0);
  }

  @override
  void resetPeak() {
    _peakDb = 0.0;
  }
}
