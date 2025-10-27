import 'dart:typed_data';
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

  bool _prepared = false;
  Future<void>? _preparing; // eşzamanlı prepare'leri engelle

  Future<void> _ensurePrepared() async {
    if (_prepared) return;
    _preparing ??= () async {
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

      // Her player için AYRI kaynak
      final srcL = InMemoryAudioSource(Uint8List.fromList(bytes));
      final srcR = InMemoryAudioSource(Uint8List.fromList(bytes));

      await Future.wait([
        _left.setAudioSource(srcL),
        _right.setAudioSource(srcR),
      ]);

      await Future.wait([
        _left.setLoopMode(LoopMode.one),
        _right.setLoopMode(LoopMode.one),
      ]);

      // Başlangıçta ikisini de sessize al/pause et
      await Future.wait([
        _left.setVolume(0),
        _right.setVolume(0),
        _left.pause(),
        _right.pause(),
      ]);

      _prepared = true;
    }();

    await _preparing;
  }

  @override
  Future<void> play(StereoChannel channel) async {
    await _ensurePrepared();

    switch (channel) {
      case StereoChannel.left:
        await _right.pause();
        await _right.setVolume(0);
        await _left.setVolume(1);
        await _left.seek(Duration.zero);
        await _left.play();
        break;

      case StereoChannel.right:
        await _left.pause();
        await _left.setVolume(0);
        await _right.setVolume(1);
        await _right.seek(Duration.zero);
        await _right.play();
        break;

      default:
        break;
    }
  }

  @override
  Future<void> stop() async {
    await Future.wait([
      _left.pause(),
      _right.pause(),
      _left.seek(Duration.zero),
      _right.seek(Duration.zero),
    ]);
  }

  @override
  Future<void> dispose() async {
    await Future.wait([_left.dispose(), _right.dispose()]);
  }
}
