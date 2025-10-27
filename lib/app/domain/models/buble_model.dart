class Bubble {
  final double size;
  final double left;
  final int duration;
  final double bottom;

  Bubble({
    this.size = 20.0,
    this.left = 0.0,
    this.duration = 2000,
    this.bottom = 0.0,
  });

  Bubble copyWith({double? size, double? left, int? duration, double? bottom}) {
    return Bubble(
      size: size ?? this.size,
      left: left ?? this.left,
      duration: duration ?? this.duration,
      bottom: bottom ?? this.bottom,
    );
  }
}
