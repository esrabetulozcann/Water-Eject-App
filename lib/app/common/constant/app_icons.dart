import 'package:flutter/material.dart';

enum AppIcons {
  stop, // Dur buton ikonu
  waterDrop, // Su damlası ikonu
  settings, // Ayarlar ikonu
  vibration, // Titreşim ikonu
  time, // Zamanlayıcı ikonu
  graphicEq, // grafik
  waves, // dalgalar
  mic, // mikrofon ikonu
  musicNote, // müzik notası ikonu
  block, // engelleme ikonu
  flash, // flaş ikonu
  volume, // ses açma ikonu
  close, // kapatma ikonu
  refresh, // yenile ikonu
  volumeDown,
  volumeUp,
  stopRounded,
  playArrowRounded,
  playArrow,
  waterDropOutlined,
  recordVoice,
  surroundSound,
  play, // oynat ikonu
  darkMode,
  language,
  chevronRight,
  info,
  share,
  star,
  privacy,
}

extension AppIconsExtension on AppIcons {
  IconData get iconData {
    switch (this) {
      case AppIcons.stop:
        return Icons.stop;
      case AppIcons.waterDrop:
        return Icons.water_drop;
      case AppIcons.settings:
        return Icons.settings;
      case AppIcons.vibration:
        return Icons.vibration;
      case AppIcons.time:
        return Icons.timer_outlined;
      case AppIcons.graphicEq:
        return Icons.graphic_eq;
      case AppIcons.waves:
        return Icons.waves;
      case AppIcons.mic:
        return Icons.mic;
      case AppIcons.musicNote:
        return Icons.music_note;
      case AppIcons.block:
        return Icons.block;
      case AppIcons.flash:
        return Icons.flash_on;
      case AppIcons.volume:
        return Icons.volume_up;
      case AppIcons.close:
        return Icons.close;
      case AppIcons.refresh:
        return Icons.refresh_rounded;
      case AppIcons.volumeDown:
        return Icons.volume_down_rounded;
      case AppIcons.volumeUp:
        return Icons.volume_up_rounded;
      case AppIcons.stopRounded:
        return Icons.stop_rounded;
      case AppIcons.playArrowRounded:
        return Icons.play_arrow_rounded;
      case AppIcons.playArrow:
        return Icons.play_arrow;
      case AppIcons.waterDropOutlined:
        return Icons.water_drop_outlined;
      case AppIcons.recordVoice:
        return Icons.record_voice_over;
      case AppIcons.surroundSound:
        return Icons.surround_sound;
      case AppIcons.play:
        return Icons.play_arrow;
      case AppIcons.darkMode:
        return Icons.dark_mode_outlined;
      case AppIcons.language:
        return Icons.language_outlined;
      case AppIcons.chevronRight:
        return Icons.chevron_right;
      case AppIcons.info:
        return Icons.info_outline;
      case AppIcons.share:
        return Icons.share_outlined;
      case AppIcons.star:
        return Icons.star_border_outlined;
      case AppIcons.privacy:
        return Icons.privacy_tip_outlined;
    }
  }
}
