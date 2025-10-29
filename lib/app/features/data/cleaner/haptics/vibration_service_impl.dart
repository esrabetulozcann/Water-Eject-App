import 'package:vibration/vibration.dart';
import 'package:water_eject/app/domain/services/vibration_service.dart';

class VibrationServiceImpl implements IVibrationService {
  @override
  Future<bool> isSupported() async => await Vibration.hasVibrator();

  @override
  Future<void> vibrate({
    required int durationMs,
    required int amplitude,
  }) async {
    await Vibration.vibrate(duration: durationMs, amplitude: amplitude);
  }

  @override
  Future<void> cancel() => Vibration.cancel();
}
