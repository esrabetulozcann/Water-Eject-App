import 'package:equatable/equatable.dart';

class SoundLevelModel extends Equatable {
  final double db; // Anlık (EMA + kalibrasyon uygulanmış) dB
  final double peakDb; // O ana kadarki tepe dB
  final DateTime timestamp; // Örnekleme zamanı

  const SoundLevelModel({
    required this.db,
    required this.peakDb,
    required this.timestamp,
  });

  SoundLevelModel copyWith({double? db, double? peakDb, DateTime? timestamp}) {
    return SoundLevelModel(
      db: db ?? this.db,
      peakDb: peakDb ?? this.peakDb,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [db, peakDb, timestamp];
}
