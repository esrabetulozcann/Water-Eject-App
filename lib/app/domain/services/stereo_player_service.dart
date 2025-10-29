import 'package:water_eject/app/common/enum/stereo_channel_enum.dart';

abstract class StereoPlayer {
  Future<void> play(StereoChannel channel);
  Future<void> stop();
  Future<void> dispose();
}
