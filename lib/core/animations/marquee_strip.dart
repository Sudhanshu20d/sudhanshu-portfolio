import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class MarqueeStrip extends StatefulWidget {
  final List<String> items;
  final double height;
  final double speed;

  const MarqueeStrip({
    super.key,
    required this.items,
    this.height = 48.0,
    this.speed = 40.0,
  });

  @override
  State<MarqueeStrip> createState() => _MarqueeStripState();
}

class _MarqueeStripState extends State<MarqueeStrip> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D11),
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FractionalTranslation(
              translation: Offset(-_controller.value * 0.5, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContent(),
                  _buildContent(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.items.map((item) {
        final isDot = item == '•';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            item,
            style: isDot
                ? AppTypography.monoLabel(color: AppColors.accent, fontSize: 14)
                : AppTypography.monoLabel(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ).copyWith(letterSpacing: 2.0, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }
}
