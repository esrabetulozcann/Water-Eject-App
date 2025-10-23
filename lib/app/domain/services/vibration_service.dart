abstract class IVibrationService {
  Future<bool> isSupported();
  Future<void> vibrate({required int durationMs, required int amplitude});
  Future<void> cancel();
}
