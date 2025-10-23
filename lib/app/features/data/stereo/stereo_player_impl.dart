import 'package:just_audio/just_audio.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_state.dart';
import 'package:water_eject/app/features/data/stereo/stereo_player.dart';
import 'package:water_eject/app/features/data/cleaner/audio/in_memory_audio_source.dart';
import 'package:water_eject/app/features/data/cleaner/audio/tone_generator.dart';

class StereoPlayerImpl implements StereoPlayer {
  final _left = AudioPlayer();
  final _right = AudioPlayer();

  final int _durationMs = 600;
  final double _baseHz = 440;
  final double _volume = 0.9;

  Future<void> _prepare() async {
    final bytes = ToneGenerator.richToneWav(
      baseHz: _baseHz,
      durationMs: _durationMs,
      volume: _volume,
      h2: 0.2,
      h3: 0.08,
      noiseMix: 0.02,
      attackMs: 5,
      releaseMs: 5,
    );
    final src = InMemoryAudioSource(bytes);
    await _left.setAudioSource(src);
    await _right.setAudioSource(src);
    await _left.setLoopMode(LoopMode.one);
    await _right.setLoopMode(LoopMode.one);
  }

  @override
  Future<void> play(StereoChannel channel) async {
    await _prepare();

    // Seçili kanalı açık bırak, diğerini kısacak
    switch (channel) {
      case StereoChannel.left:
        await _right.setVolume(0.0);
        await _left.setVolume(1.0);
        await _left.seek(Duration.zero);
        await _left.play();
        break;
      case StereoChannel.right:
        await _left.setVolume(0.0);
        await _right.setVolume(1.0);
        await _right.seek(Duration.zero);
        await _right.play();
        break;
      default:
        // none → hiçbir şey
        break;
    }
  }

  @override
  Future<void> stop() async {
    await _left.stop();
    await _right.stop();
  }

  @override
  Future<void> dispose() async {
    await _left.dispose();
    await _right.dispose();
  }
}
