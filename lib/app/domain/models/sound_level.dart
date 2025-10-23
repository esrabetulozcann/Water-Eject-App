import 'package:equatable/equatable.dart';

class SoundLevel extends Equatable {
  final double db; // Anlık (EMA + kalibrasyon uygulanmış) dB
  final double peakDb; // O ana kadarki tepe dB
  final DateTime timestamp; // Örnekleme zamanı

  const SoundLevel({
    required this.db,
    required this.peakDb,
    required this.timestamp,
  });

  SoundLevel copyWith({double? db, double? peakDb, DateTime? timestamp}) {
    return SoundLevel(
      db: db ?? this.db,
      peakDb: peakDb ?? this.peakDb,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [db, peakDb, timestamp];
}
