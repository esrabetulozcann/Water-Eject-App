import 'dart:async';
import 'package:water_eject/app/domain/models/calibration_value_model.dart';
import 'package:water_eject/app/domain/models/sound_level_model.dart';

abstract class SoundLevelRepository {
  Future<void> start({
    CalibrationValueModel calibration = const CalibrationValueModel(0),
    double smoothingAlpha = 0.2, // 0-1 arası EMA
  });

  Future<void> stop();

  void setCalibration(CalibrationValueModel calibration);
  void setSmoothing(double alpha);
  void resetPeak();

  /// Ölçüm akışı (calibrated + smoothed dB ve peak)
  Stream<SoundLevelModel> get levels;
}
