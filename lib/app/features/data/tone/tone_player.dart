import 'package:water_eject/app/domain/services/tone_player_service.dart';
import 'package:water_eject/app/features/data/cleaner/audio/just_audio_engine.dart';
import 'package:water_eject/app/features/data/cleaner/audio/tone_generator.dart';

class TonePlayer implements ITonePlayer {
  final JustAudioEngine _engine;
  bool _playing = false;

  TonePlayer(this._engine);

  @override
  Future<void> start(double hz) async {
    final bytes = _buildWav(hz);
    await _engine.prepareFromBytes(bytes);
    await _engine.play();
    _playing = true;
  }

  @override
  Future<void> setFrequency(double hz) async {
    if (!_playing) return;
    final bytes = _buildWav(hz);
    await _engine.prepareFromBytes(bytes);
    await _engine.play();
  }

  @override
  Future<void> stop() async {
    _playing = false;
    await _engine.stop();
  }

  @override
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
