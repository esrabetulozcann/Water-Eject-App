import 'package:equatable/equatable.dart';

class ToneState extends Equatable {
  final double freq; // anlık Hz
  final double prevFreq; // önceki Hz
  final bool isPlaying; // çalıyor mu
  final double minHz; // 20
  final double maxHz; // 300

  const ToneState({
    required this.freq,
    required this.isPlaying,
    required this.minHz,
    required this.maxHz,
    required this.prevFreq,
  });

  factory ToneState.initial() => const ToneState(
    freq: 165,
    isPlaying: false,
    minHz: 20,
    maxHz: 300,
    prevFreq: 165,
  );

  ToneState copyWith({
    double? freq,
    bool? isPlaying,
    double? prevFreq,
    double? minHz,
    double? maxHz,
  }) {
    return ToneState(
      freq: freq ?? this.freq,
      isPlaying: isPlaying ?? this.isPlaying,
      minHz: minHz ?? this.minHz,
      maxHz: maxHz ?? this.maxHz,
      prevFreq: prevFreq ?? this.prevFreq,
    );
  }

  @override
  List<Object> get props => [freq, isPlaying, prevFreq, minHz, maxHz];
}
