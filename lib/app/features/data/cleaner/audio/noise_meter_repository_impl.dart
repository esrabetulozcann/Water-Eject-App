import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:water_eject/app/domain/models/calibration_value_model.dart';
import 'package:water_eject/app/domain/models/sound_level_model.dart';
import 'package:water_eject/app/domain/repositories/sound_level_repository.dart';

//cihazın mikrofonundan gelen ses seviyesini (dB) ölçmek
class NoiseMeterRepositoryImpl implements SoundLevelRepository {
  late final NoiseMeter _noiseMeter;
  StreamSubscription<NoiseReading>? _subscription;

  final StreamController<SoundLevelModel> _controller =
      StreamController<SoundLevelModel>.broadcast();

  @override
  Stream<SoundLevelModel> get levels => _controller.stream;

  double _ema = 0.0; // Exponential Moving Average (dB)
  double _alpha = 0.2; // Smoothing (0-1)
  double _peakDb = 0.0; // Peak dB
  CalibrationValueModel _calibration = const CalibrationValueModel(0);

  NoiseMeterRepositoryImpl() {
    _noiseMeter = NoiseMeter(); // parametresiz ctor
  }

  static void _onError(Object e) {
    // burayı yapacağım
  }

  @override
  Future<void> start({
    CalibrationValueModel calibration = const CalibrationValueModel(0),
    double smoothingAlpha = 0.2,
  }) async {
    _calibration = calibration;
    _alpha = smoothingAlpha.clamp(0.0, 1.0);
    _ema = 0.0;
    _peakDb = 0.0;

    _subscription = _noiseMeter.noise.listen(
      (reading) {
        final rawDb = reading.meanDecibel;

        // EMA: ilk örnekle başlat
        _ema = (_ema == 0.0) ? rawDb : (_alpha * rawDb + (1 - _alpha) * _ema);

        final calibrated = _ema + _calibration.offsetDb;
        if (calibrated > _peakDb) _peakDb = calibrated;

        _controller.add(
          SoundLevelModel(
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
  void setCalibration(CalibrationValueModel calibration) {
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
