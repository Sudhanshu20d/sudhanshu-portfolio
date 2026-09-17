import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum MagneticButtonStyle { primary, secondary, outline }

class MagneticButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final MagneticButtonStyle style;
  final bool isSmall;

  const MagneticButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.style = MagneticButtonStyle.primary,
    this.isSmall = false,
  });

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;
    List<BoxShadow> shadows = [];

    switch (widget.style) {
      case MagneticButtonStyle.primary:
        bgColor = _isHovered ? AppColors.accent : const Color(0xFF1E1B2E);
        textColor = _isHovered ? Colors.black : AppColors.textPrimary;
        border = Border.all(
          color: _isHovered ? AppColors.accent : AppColors.accent.withValues(alpha: 0.35),
          width: 1.2,
        );
        if (_isHovered) {
          shadows = [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.4),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ];
        }
        break;

      case MagneticButtonStyle.secondary:
        bgColor = _isHovered ? const Color(0x22FFFFFF) : const Color(0x10FFFFFF);
        textColor = AppColors.textPrimary;
        border = Border.all(
          color: _isHovered ? const Color(0x40FFFFFF) : AppColors.border,
          width: 1,
        );
        break;

      case MagneticButtonStyle.outline:
        bgColor = _isHovered ? AppColors.accent.withValues(alpha: 0.12) : Colors.transparent;
        textColor = _isHovered ? AppColors.accent : AppColors.textMuted;
        border = Border.all(
          color: _isHovered ? AppColors.accent : AppColors.border,
          width: 1,
        );
        break;
    }

    final double verticalPadding = widget.isSmall ? 10 : 14;
    final double horizontalPadding = widget.isSmall ? 18 : 26;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: border,
            boxShadow: shadows,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: AppTypography.buttonText(color: textColor).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: widget.isSmall ? 13 : 14,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(_isHovered ? 3 : 0, 0, 0),
                  child: Icon(
                    widget.icon,
                    size: widget.isSmall ? 14 : 16,
                    color: textColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
