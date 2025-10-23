import 'package:water_eject/app/features/data/cleaner/audio/just_audio_engine.dart';
import 'package:water_eject/app/features/data/cleaner/audio/tone_generator.dart';

/// Basit oynatıcı adaptör: start / setFrequency / stop
class TonePlayer {
  final JustAudioEngine _engine;
  bool _playing = false;
  double _currentHz = 165;

  TonePlayer(this._engine);

  Future<void> start(double hz) async {
    _currentHz = hz;
    final bytes = _buildWav(hz);

    await _engine.prepareFromBytes(bytes);
    await _engine.play();
    _playing = true;
  }

  Future<void> setFrequency(double hz) async {
    _currentHz = hz;
    if (!_playing) return;
    final bytes = _buildWav(hz);
    // Hz değişince yeni wav'ı hazırlayıp hemen çalıyoruz
    await _engine.prepareFromBytes(bytes);
    await _engine.play();
  }

  Future<void> stop() async {
    _playing = false;
    await _engine.stop();
  }

  Future<void> dispose() async {
    _playing = false;
    await _engine.dispose();
  }

  List<int> _buildWav(double hz) {
    return ToneGenerator.richToneWav(
      baseHz: hz,
      durationMs: 800,
      sampleRate: 44100,
      volume: 0.9,

      h2: 0.05,
      h3: 0.02,
      noiseMix: 0.01,
      attackMs: 4,
      releaseMs: 4,
    );
  }
}
