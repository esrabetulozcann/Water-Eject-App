import 'package:get_it/get_it.dart';
import 'package:water_eject/app/domain/services/tone_player_service.dart';
import 'package:water_eject/app/features/data/stereo/stereo_player.dart';
import 'package:water_eject/app/features/data/stereo/stereo_player_impl.dart';
import 'package:water_eject/app/features/data/tone/tone_player.dart';

// === Cleaner ===
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/app/features/data/cleaner/audio/just_audio_engine.dart';
import 'package:water_eject/app/features/data/cleaner/haptics/vibration_service_impl.dart';

// === DbMeter ===
import 'package:water_eject/app/features/data/cleaner/audio/noise_meter_repository_impl.dart';
import 'package:water_eject/app/domain/repositories/sound_level_repository.dart';
import 'package:water_eject/app/features/presentation/db_meter/cubit/dbmeter_cubit.dart';
import 'package:water_eject/app/features/presentation/paywall/cubit/paywall_selection_cubit.dart';
import 'package:water_eject/app/features/presentation/setting/cubit/setting_cubit.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_cubit.dart';
import 'package:water_eject/app/features/presentation/tone/cubit/tone_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Services (Cleaner)
  sl.registerLazySingleton(() => JustAudioEngine());
  sl.registerLazySingleton(() => VibrationServiceImpl());

  // Cleaner Cubit
  sl.registerFactory(
    () => CleanerCubit(
      audio: sl<JustAudioEngine>(),
      vibration: sl<VibrationServiceImpl>(),
    ),
  );

  // === DbMeter bindings ===
  sl.registerLazySingleton<SoundLevelRepository>(
    () => NoiseMeterRepositoryImpl(),
  );
  sl.registerFactory(() => DbMeterCubit(sl<SoundLevelRepository>()));

  // lib/core/di/locator.dart
  sl.registerFactoryParam<SettingCubit, ({bool isDark, bool isEnglish}), void>(
    (params, _) =>
        SettingCubit(isDark: params.isDark, isEnglish: params.isEnglish),
  );

  // Stereo
  sl.registerLazySingleton<StereoPlayer>(() => StereoPlayerImpl());
  sl.registerFactory(() => StereoCubit(sl<StereoPlayer>()));

  //Tone Player
  sl.registerFactory<ITonePlayer>(
    () => TonePlayer(sl<JustAudioEngine>()),
  ); // <-- interface -> impl
  sl.registerFactory(() => ToneCubit(sl<ITonePlayer>()));

  //paywall
  sl.registerFactory(() => PaywallSelectionCubit());
}
