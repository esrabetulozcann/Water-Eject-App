import 'dart:async';
import 'package:water_eject/app/domain/models/calibration_value.dart';
import 'package:water_eject/app/domain/models/sound_level.dart';

abstract class SoundLevelRepository {
  Future<void> start({
    CalibrationValue calibration = const CalibrationValue(0),
    double smoothingAlpha = 0.2, // 0-1 arası EMA
  });

  Future<void> stop();

  void setCalibration(CalibrationValue calibration);
  void setSmoothing(double alpha);
  void resetPeak();

  /// Ölçüm akışı (calibrated + smoothed dB ve peak)
  Stream<SoundLevel> get levels;
}
