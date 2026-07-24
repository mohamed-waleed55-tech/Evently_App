import 'package:evently/features/authentication/widgets/wavy_background_painter.dart';
import 'package:flutter/material.dart';

class WavyBackground extends StatelessWidget {
  const WavyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: RepaintBoundary(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: CustomPaint(
            size: Size(size.width, size.height),
            painter: VerticalWavyBackgroundPainter(
              primaryColor: theme.primary,
              secondaryColor: theme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}