abstract class ITonePlayer {
  Future<void> start(double hz);
  Future<void> setFrequency(double hz);
  Future<void> stop();
  Future<void> dispose();
}
