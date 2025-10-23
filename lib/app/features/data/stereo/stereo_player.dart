import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_state.dart';

abstract class StereoPlayer {
  /// Belirli bir kanaldan (sol/sağ) test sesi çalar
  Future<void> play(StereoChannel channel);

  /// Çalan sesi durdurur
  Future<void> stop();

  /// Kaynakları serbest bırakır
  Future<void> dispose();
}
