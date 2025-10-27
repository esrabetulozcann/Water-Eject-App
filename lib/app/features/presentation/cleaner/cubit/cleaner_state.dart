import 'package:equatable/equatable.dart';
import 'package:water_eject/app/domain/models/buble_model.dart';
import '../../../../common/enum/cleaner_mode_enum.dart';
import '../../../../common/enum/intensity_enum.dart';

class CleanerState extends Equatable {
  final bool running;
  final double progress;
  final String? error;
  final CleanerMode mode;
  final Intensity intensity;
  final bool vibrationEnabled;
  final int durationSec;
  final int remainingSec;
  final double currentHz; // anlık Hz (sweep’te değişir)
  final double frequencyHz; // tone modunda seçilen Hz
  final List<Bubble> bubbles; // baloncuk listesi
  final bool showBubbles; // baloncukların gösterilip gösterilmeyeceği

  const CleanerState({
    this.running = false,
    this.progress = 0,
    this.error,
    this.mode = CleanerMode.sweep,
    this.intensity = Intensity.medium,
    this.vibrationEnabled = true,
    this.durationSec = 30,
    this.remainingSec = 30,
    this.currentHz = 165,
    this.frequencyHz = 165,
    this.bubbles = const [],
    this.showBubbles = false,
  });

  CleanerState copyWith({
    bool? running,
    double? progress,
    String? error,
    CleanerMode? mode,
    Intensity? intensity,
    bool? vibrationEnabled,
    int? durationSec,
    int? remainingSec,
    double? currentHz,
    double? frequencyHz,
    List<Bubble>? bubbles,
    bool? showBubbles,
  }) {
    return CleanerState(
      running: running ?? this.running,
      progress: progress ?? this.progress,
      error: error,
      mode: mode ?? this.mode,
      intensity: intensity ?? this.intensity,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      durationSec: durationSec ?? this.durationSec,
      remainingSec: remainingSec ?? this.remainingSec,
      currentHz: currentHz ?? this.currentHz,
      frequencyHz: frequencyHz ?? this.frequencyHz,
      bubbles: bubbles ?? this.bubbles,
      showBubbles: showBubbles ?? this.showBubbles,
    );
  }

  @override
  List<Object?> get props => [
    running,
    progress,
    error,
    mode,
    intensity,
    vibrationEnabled,
    durationSec,
    remainingSec,
    currentHz,
    frequencyHz,
    bubbles,
    showBubbles,
  ];
}
