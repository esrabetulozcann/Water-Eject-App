import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/colors.dart';

class DecibelGauge extends StatelessWidget {
  final double value; // anlık dB
  final double peak; // peak dB
  final double min;
  final double max;
  final String label;

  const DecibelGauge({
    super.key,
    required this.value,
    required this.peak,
    this.min = 0,
    this.max = 120,
    this.label = "dB",
  });

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(min, max);
    final p = peak.clamp(min, max);
    final ratio = (v - min) / (max - min);
    final peakRatio = (p - min) / (max - min);

    return CustomPaint(
      size: const Size(260, 260),
      painter: _GaugePainter(ratio: ratio, peakRatio: peakRatio),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value.toStringAsFixed(1),
              style: Theme.of(context).textTheme.displaySmall,
            ),

            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double ratio;
  final double peakRatio;

  _GaugePainter({required this.ratio, required this.peakRatio});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 16.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (math.min(size.width, size.height) / 2) - stroke;

    final startAngle = math.pi * 0.75; // 135°
    final sweepAngle = math.pi * 1.5; // 270°

    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = AppColors.dbBackground;

    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: const [
          AppColors.dbSoft, // düşük
          AppColors.dbMedium, // orta
          AppColors.dbStrong, // yüksek
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Base arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      basePaint,
    );

    // Active arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * ratio,
      false,
      activePaint,
    );

    // Peak indicator
    final peakPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = AppColors.dbIndicator;

    final peakAngle = startAngle + sweepAngle * peakRatio;
    final p1 = Offset(
      center.dx + (radius - stroke) * math.cos(peakAngle),
      center.dy + (radius - stroke) * math.sin(peakAngle),
    );
    final p2 = Offset(
      center.dx + (radius + 6) * math.cos(peakAngle),
      center.dy + (radius + 6) * math.sin(peakAngle),
    );
    canvas.drawLine(p1, p2, peakPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.ratio != ratio || oldDelegate.peakRatio != peakRatio;
  }
}
