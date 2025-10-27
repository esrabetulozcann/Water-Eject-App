abstract class IAudioEngine {
  Future<void> prepareFromBytes(List<int> wavBytes);
  Future<void> play();
  Future<void> stop();
  Stream<AudioPlayerSnapshot> get playerState$;
}

class AudioPlayerSnapshot {
  final bool playing;
  final String processing;
  const AudioPlayerSnapshot({required this.playing, required this.processing});
}
