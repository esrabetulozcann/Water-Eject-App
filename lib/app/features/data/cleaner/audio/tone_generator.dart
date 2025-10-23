import 'dart:math';
import 'dart:typed_data';

class ToneGenerator {
  /// Çok amaçlı tek ton (AM/FM + harmonikler + hafif noise)
  static Uint8List richToneWav({
    required double baseHz,
    required int durationMs,
    int sampleRate = 44100,
    double volume = 0.8,
    // Vibrato (FM)
    double vibratoRateHz = 0.0, // 0 = kapalı
    double vibratoDepthCents = 0.0, // +/- kaç cent
    // Tremolo (AM)
    double tremoloRateHz = 0.0,
    double tremoloDepth = 0.0, // 0..1
    // Harmonic mix
    double h2 = 0.0, // 2. harmonik katsayısı
    double h3 = 0.0, // 3. harmonik katsayısı
    // Noise mix (çok küçük değerler)
    double noiseMix = 0.0, // 0..0.2 önerilir
    // Envelope
    double attackMs = 5,
    double releaseMs = 5,
  }) {
    final samples = (sampleRate * durationMs / 1000).round();
    final data = BytesBuilder();
    data.add(_wavHeader(sampleRate, samples, 1, 16));

    final fadeIn = (attackMs * sampleRate / 1000)
        .clamp(1, samples ~/ 2)
        .round();
    final fadeOut = (releaseMs * sampleRate / 1000)
        .clamp(1, samples ~/ 2)
        .round();
    final rng = Random();

    // FM için cent → ratio
    double centsToRatio(double cents) => pow(2, cents / 1200).toDouble();

    for (int n = 0; n < samples; n++) {
      final t = n / sampleRate;

      // Envelope (attack/release)
      double env = 1.0;
      if (n < fadeIn) {
        env = n / fadeIn;
      } else if (n > samples - fadeOut) {
        env = (samples - n) / fadeOut;
      }

      // Tremolo (AM)
      final am = tremoloDepth > 0
          ? (1.0 - tremoloDepth) +
                tremoloDepth * 0.5 * (1 + sin(2 * pi * (tremoloRateHz) * t))
          : 1.0;

      // Vibrato (FM) → anlık frekans
      final fmRatio = vibratoDepthCents > 0
          ? centsToRatio(vibratoDepthCents * sin(2 * pi * vibratoRateHz * t))
          : 1.0;
      final f = baseHz * fmRatio;

      // Temel dalga + harmonikler
      final fundamental = sin(2 * pi * f * t);
      final second = h2 != 0 ? h2 * sin(2 * pi * (2 * f) * t) : 0.0;
      final third = h3 != 0 ? h3 * sin(2 * pi * (3 * f) * t) : 0.0;

      // Noise (çok az)
      final noise = noiseMix > 0 ? noiseMix * (rng.nextDouble() * 2 - 1) : 0.0;

      final sample = (fundamental + second + third + noise) * volume * env * am;

      final v = (sample * 32767.0).clamp(-32768, 32767).toInt();
      data.add([v & 0xFF, (v >> 8) & 0xFF]);
    }
    final bytes = data.toBytes();
    _patchWavSizes(bytes);
    return bytes;
  }

  /// Log sweep + AM (arzu edersen vibrato da eklenebilir)
  static Uint8List richLogSweepWav({
    required double startHz,
    required double endHz,
    required int durationMs,
    int sampleRate = 44100,
    double volume = 0.9,
    // Tremolo (AM)
    double tremoloRateHz = 0.0,
    double tremoloDepth = 0.0,
    // Harmonic mix
    double h2 = 0.0,
    double h3 = 0.0,
    double noiseMix = 0.0,
    double attackMs = 10,
    double releaseMs = 10,
  }) {
    final samples = (sampleRate * durationMs / 1000).round();
    final data = BytesBuilder();
    data.add(_wavHeader(sampleRate, samples, 1, 16));

    final fadeIn = (attackMs * sampleRate / 1000)
        .clamp(1, samples ~/ 2)
        .round();
    final fadeOut = (releaseMs * sampleRate / 1000)
        .clamp(1, samples ~/ 2)
        .round();
    final rng = Random();

    // Log sweep fazı
    final K = durationMs / 1000.0 / log(endHz / startHz);
    final L = startHz;

    for (int n = 0; n < samples; n++) {
      final t = n / sampleRate;
      final phase = 2 * pi * L * K * (exp(t / K) - 1);
      //final instFreq = L * exp(t / K); // anlık frekans (debug için)

      // Envelope
      double env = 1.0;
      if (n < fadeIn) {
        env = n / fadeIn;
      } else if (n > samples - fadeOut) {
        env = (samples - n) / fadeOut;
      }

      // Tremolo (AM)
      final am = tremoloDepth > 0
          ? (1.0 - tremoloDepth) +
                tremoloDepth * 0.5 * (1 + sin(2 * pi * (tremoloRateHz) * t))
          : 1.0;

      final fundamental = sin(phase);
      final second = h2 != 0 ? h2 * sin(2 * phase) : 0.0;
      final third = h3 != 0 ? h3 * sin(3 * phase) : 0.0;
      final noise = noiseMix > 0 ? noiseMix * (rng.nextDouble() * 2 - 1) : 0.0;

      final sample = (fundamental + second + third + noise) * volume * env * am;

      final v = (sample * 32767.0).clamp(-32768, 32767).toInt();
      data.add([v & 0xFF, (v >> 8) & 0xFF]);
    }
    final bytes = data.toBytes();
    _patchWavSizes(bytes);
    return bytes;
  }

  // ------- (mevcut header/sizes yardımcıları aşağıda aynı) -------
  static Uint8List _wavHeader(
    int sampleRate,
    int numSamples,
    int channels,
    int bitsPerSample,
  ) {
    final byteRate = sampleRate * channels * bitsPerSample ~/ 8;
    final blockAlign = channels * bitsPerSample ~/ 8;
    final dataChunkSize = numSamples * channels * bitsPerSample ~/ 8;
    final totalSize = 36 + dataChunkSize;

    final header = BytesBuilder();
    header.add("RIFF".codeUnits);
    header.add(_le32(totalSize));
    header.add("WAVE".codeUnits);
    header.add("fmt ".codeUnits);
    header.add(_le32(16));
    header.add(_le16(1));
    header.add(_le16(channels));
    header.add(_le32(sampleRate));
    header.add(_le32(byteRate));
    header.add(_le16(blockAlign));
    header.add(_le16(bitsPerSample));
    header.add("data".codeUnits);
    header.add(_le32(dataChunkSize));
    return header.toBytes();
  }

  static void _patchWavSizes(Uint8List bytes) {
    final dataSize = bytes.length - 44;
    final totalSize = 36 + dataSize;
    _writeLe32(bytes, 4, totalSize);
    _writeLe32(bytes, 40, dataSize);
  }

  static List<int> _le16(int v) => [v & 0xFF, (v >> 8) & 0xFF];
  static List<int> _le32(int v) => [
    v & 0xFF,
    (v >> 8) & 0xFF,
    (v >> 16) & 0xFF,
    (v >> 24) & 0xFF,
  ];
  static void _writeLe32(Uint8List b, int o, int v) {
    b[o + 0] = (v >> 0) & 0xFF;
    b[o + 1] = (v >> 8) & 0xFF;
    b[o + 2] = (v >> 16) & 0xFF;
    b[o + 3] = (v >> 24) & 0xFF;
  }
}
