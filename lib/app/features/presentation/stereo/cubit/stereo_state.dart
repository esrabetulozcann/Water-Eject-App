import 'package:equatable/equatable.dart';

enum StereoChannel { none, left, right }

class StereoState extends Equatable {
  final bool isTesting;
  final bool autoLoop;
  final StereoChannel active; // şu an çalan kanal (UI highlight)
  final StereoChannel selected; // kullanıcı seçimi (başlat’ta kullanılır)
  final Duration stepDuration;

  const StereoState({
    required this.isTesting,
    required this.autoLoop,
    required this.active,
    required this.selected,
    required this.stepDuration,
  });

  factory StereoState.initial() => const StereoState(
    isTesting: false,
    autoLoop: false,
    active: StereoChannel.none,
    selected: StereoChannel.left, // varsayılan seçim
    stepDuration: Duration(seconds: 1),
  );

  StereoState copyWith({
    bool? isTesting,
    bool? autoLoop,
    StereoChannel? active,
    StereoChannel? selected,
    Duration? stepDuration,
  }) {
    return StereoState(
      isTesting: isTesting ?? this.isTesting,
      autoLoop: autoLoop ?? this.autoLoop,
      active: active ?? this.active,
      selected: selected ?? this.selected,
      stepDuration: stepDuration ?? this.stepDuration,
    );
  }

  @override
  List<Object> get props => [
    isTesting,
    autoLoop,
    active,
    selected,
    stepDuration,
  ];
}
