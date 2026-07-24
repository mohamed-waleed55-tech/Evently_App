import 'package:flutter/material.dart';

class VerticalWavyBackgroundPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  VerticalWavyBackgroundPainter({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final baseGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        primaryColor.withValues(alpha: 0.12),
        secondaryColor.withValues(alpha: 0.05),
      ],
    );
    final basePaint = Paint()..shader = baseGradient.createShader(rect);
    canvas.drawRect(rect, basePaint);

    final gradient1 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor.withValues(alpha: 0.55),
        secondaryColor.withValues(alpha: 0.25),
      ],
    );

    final paint1 = Paint()..shader = gradient1.createShader(rect);

    final path1 = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.22)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.28,
        size.width * 0.70,
        size.height * 0.15,
        size.width,
        size.height * 0.20,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path1, paint1);

    final paint1Accent = Paint()
      ..color = primaryColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final path1Accent = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.25,
        size.width,
        size.height * 0.14,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path1Accent, paint1Accent);

    final gradient2 = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        primaryColor.withValues(alpha: 0.40),
        secondaryColor.withValues(alpha: 0.25),
      ],
    );

    final paint2 = Paint()..shader = gradient2.createShader(rect);

    final path2 = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.82)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.76,
        size.width * 0.65,
        size.height * 0.90,
        size.width,
        size.height * 0.84,
      )
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}