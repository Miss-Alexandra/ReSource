import 'dart:math';
import 'package:flutter/material.dart';

class MoodIndicatorPainter extends CustomPainter {
  final double progress;
  final Color ringColor;
  final double ringStrokeWidth;

  MoodIndicatorPainter({
    required this.progress,
    required this.ringColor,
    required this.ringStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final ringRadius = (size.width - ringStrokeWidth) / 2 - 8;

    if (progress > 0) {
      if (progress == 1.0) {
        final paint = Paint()
          ..color = ringColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = ringStrokeWidth;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: ringRadius),
          -pi / 2,
          2 * pi,
          false,
          paint,
        );
      } else {
        final double startAngle = -pi / 2;
        final double sweepAngle = 2 * pi * progress;
        const int segments = 100;
        final double segmentAngle = sweepAngle / segments;
        final double fadeStart = sweepAngle * 0.9;

        for (int i = 0; i < segments; i++) {
          final double angleStart = startAngle + i * segmentAngle;
          final double angleEnd = angleStart + segmentAngle;
          if (angleStart > startAngle + sweepAngle) break;

          double opacity = 1.0;
          if (angleEnd > startAngle + fadeStart) {
            final double fadeProgress = (angleEnd - (startAngle + fadeStart)) / (sweepAngle - fadeStart);
            opacity = 1.0 - fadeProgress.clamp(0.0, 1.0);
          }

          final paint = Paint()
            ..color = ringColor.withOpacity(opacity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = ringStrokeWidth;

          canvas.drawArc(
            Rect.fromCircle(center: center, radius: ringRadius),
            angleStart,
            segmentAngle,
            false,
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant MoodIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringColor != ringColor ||
        oldDelegate.ringStrokeWidth != ringStrokeWidth;
  }
}