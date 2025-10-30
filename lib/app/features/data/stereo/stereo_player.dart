import 'package:water_eject/app/common/enum/stereo_channel_enum.dart';

abstract class StereoPlayer {
  /// Belirli bir kanaldan (sol/sağ) test sesi çalar
  Future<void> play(StereoChannel channel);

  /// Çalan sesi durdurur
  Future<void> stop();

  /// Kaynakları serbest bırakır
  Future<void> dispose();
}
