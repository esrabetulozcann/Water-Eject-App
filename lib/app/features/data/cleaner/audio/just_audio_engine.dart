import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';
import 'package:water_eject/app/features/data/cleaner/audio/in_memory_audio_source.dart';
import 'package:water_eject/app/domain/services/audio_engine_service.dart';

class JustAudioEngine implements IAudioEngine {
  final _player = AudioPlayer();

  @override
  Future<void> prepareFromBytes(List<int> wavBytes) async {
    final bytes = Uint8List.fromList(wavBytes);
    //Her yeni kaynağı yüklemeden önce loop'u tek parça için açtım
    await _player.setLoopMode(LoopMode.one);
    await _player.setAudioSource(InMemoryAudioSource(bytes));
    // başa sar
    await _player.seek(Duration.zero);
    // List<int> -> Uint8List
    // final bytes = Uint8List.fromList(wavBytes);
    // await _player.setAudioSource(InMemoryAudioSource(bytes));
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> stop() => _player.stop();

  @override
  Stream<AudioPlayerSnapshot> get playerState$ => _player.playerStateStream.map(
    (s) => AudioPlayerSnapshot(
      playing: s.playing,
      processing: s.processingState.name,
    ),
  );

  Future<void> dispose() => _player.dispose();
}
