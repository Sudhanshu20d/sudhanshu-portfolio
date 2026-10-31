import 'accessible_action.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum MagneticButtonStyle { primary, secondary, outline }

class MagneticButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final IconData? prefixIcon;
  final FaIconData? prefixFaIcon;
  final MagneticButtonStyle style;
  final bool isSmall;

  const MagneticButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.prefixIcon,
    this.prefixFaIcon,
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
        bgColor = _isHovered ? AppColors.accent : AppColors.textPrimary;
        textColor = _isHovered
            ? Color(0xFF0B0B0C)
            : AppColors.background; // Deep black contrast
        border = Border.all(
          color: _isHovered ? AppColors.accent : AppColors.textPrimary,
          width: 1,
        );
        break;

      case MagneticButtonStyle.secondary:
        bgColor = _isHovered ? AppColors.surface : AppColors.surface;
        textColor = AppColors.textPrimary;
        border = Border.all(
          color: _isHovered ? AppColors.accent : AppColors.borderLight,
          width: 1,
        );
        break;

      case MagneticButtonStyle.outline:
        bgColor = _isHovered ? AppColors.accentSubtle : Colors.transparent;
        textColor = _isHovered ? AppColors.accent : AppColors.textPrimary;
        border = Border.all(
          color: _isHovered ? AppColors.accent : AppColors.borderLight,
          width: 1,
        );
        break;
    }

    final double verticalPadding = widget.isSmall ? 10 : 13;
    final double horizontalPadding = widget.isSmall ? 16 : 22;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AccessibleAction(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration:
              WidgetsBinding
                  .instance
                  .platformDispatcher
                  .accessibilityFeatures
                  .disableAnimations
              ? Duration.zero
              : Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
            border: border,
            boxShadow: shadows,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.prefixFaIcon != null) ...[
                FaIcon(
                  widget.prefixFaIcon,
                  size: widget.isSmall ? 14 : 16,
                  color: textColor,
                ),
                SizedBox(width: 8),
              ] else if (widget.prefixIcon != null) ...[
                Icon(
                  widget.prefixIcon,
                  size: widget.isSmall ? 14 : 16,
                  color: textColor,
                ),
                SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.text,
                  style: AppTypography.buttonText(color: textColor).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.isSmall ? 13 : 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.icon != null) ...[
                SizedBox(width: 8),
                AnimatedContainer(
                  duration:
                      WidgetsBinding
                          .instance
                          .platformDispatcher
                          .accessibilityFeatures
                          .disableAnimations
                      ? Duration.zero
                      : Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(
                    _isHovered ? 3 : 0,
                    0,
                    0,
                  ),
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
