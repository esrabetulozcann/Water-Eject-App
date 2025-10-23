import 'package:equatable/equatable.dart';

/// Mikrofon izni durumu
enum MicPermissionStatus { unknown, granted, denied, permanentlyDenied }

/// UI'ya tek-seferlik komut/etki
sealed class DbUiEffect extends Equatable {
  const DbUiEffect();
  @override
  List<Object?> get props => [];
}

class ShowPermissionDialog extends DbUiEffect {
  final bool permanentlyDenied;
  const ShowPermissionDialog(this.permanentlyDenied);

  @override
  List<Object?> get props => [permanentlyDenied];
}

class DbMeterState extends Equatable {
  final bool isMeasuring;
  final double currentDb;
  final double peakDb;
  final MicPermissionStatus permission;

  /// Tek-seferlik UI etkisi (dinlenince temizlenecek)
  final DbUiEffect? effect;

  const DbMeterState({
    required this.isMeasuring,
    required this.currentDb,
    required this.peakDb,
    required this.permission,
    this.effect,
  });

  factory DbMeterState.initial() => const DbMeterState(
    isMeasuring: false,
    currentDb: 0,
    peakDb: 0,
    permission: MicPermissionStatus.unknown,
    effect: null,
  );

  DbMeterState copyWith({
    bool? isMeasuring,
    double? currentDb,
    double? peakDb,
    MicPermissionStatus? permission,
    DbUiEffect? effect,
  }) {
    return DbMeterState(
      isMeasuring: isMeasuring ?? this.isMeasuring,
      currentDb: currentDb ?? this.currentDb,
      peakDb: peakDb ?? this.peakDb,
      permission: permission ?? this.permission,
      effect: effect,
    );
  }

  @override
  List<Object?> get props => [
    isMeasuring,
    currentDb,
    peakDb,
    permission,
    effect,
  ];
}
