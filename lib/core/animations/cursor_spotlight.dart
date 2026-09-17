import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BackgroundGridPainter extends CustomPainter {
  final Offset mousePosition;
  final double spotlightRadius;

  BackgroundGridPainter({
    required this.mousePosition,
    this.spotlightRadius = 400.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Fill background deep obsidian
    final bgPaint = Paint()..color = AppColors.background;
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Draw moving editorial grid
    final gridPaint = Paint()
      ..color = const Color(0x08FFFFFF)
      ..strokeWidth = 1.0;

    const double step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw ambient soft spotlight following cursor
    if (mousePosition != Offset.zero) {
      final spotlightPaint = Paint()
        ..shader = RadialGradient(
          center: Alignment(
            (mousePosition.dx / size.width) * 2 - 1,
            (mousePosition.dy / size.height) * 2 - 1,
          ),
          radius: spotlightRadius / (size.shortestSide > 0 ? size.shortestSide : 1),
          colors: const [
            Color(0x12A88CFF),
            Color(0x064F46E5),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Offset.zero & size);

      canvas.drawRect(Offset.zero & size, spotlightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant BackgroundGridPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition;
  }
}
