import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedWave extends StatelessWidget {
  final double progress;
  const AnimatedWave({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 160),
      painter: _WavePainter(
        progress: progress,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  final Color color;
  _WavePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = color.withOpacity(0.9);

    final path = Path();
    final amp = 16 + 22 * progress;
    final freq = 2 + 2 * progress;
    for (int x = 0; x <= size.width; x++) {
      final t = x / size.width * 2 * pi * freq;
      final y = size.height / 2 + sin(t) * amp;
      if (x == 0)
        path.moveTo(x.toDouble(), y);
      else
        path.lineTo(x.toDouble(), y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) =>
      old.progress != progress || old.color != color;
}
