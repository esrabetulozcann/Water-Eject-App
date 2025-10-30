import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';

//uygulamadaki ses verisini cihazın dosya sistemine kaydetmeden doğrudan bellekte (RAM’de) çalışmasını sağlıyor
class InMemoryAudioSource extends StreamAudioSource {
  final Uint8List bytes;
  InMemoryAudioSource(List<int> data) : bytes = Uint8List.fromList(data);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    final slice = bytes.sublist(start, end);
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: slice.length,
      offset: start,
      stream: Stream.value(slice),
      contentType: 'audio/wav',
    );
  }
}
