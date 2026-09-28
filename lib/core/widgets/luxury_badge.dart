import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class LuxuryBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? dotColor;
  final Color borderColor;
  final Color backgroundColor;

  const LuxuryBadge({
    super.key,
    required this.label,
    this.icon,
    this.dotColor,
    this.borderColor = AppColors.border,
    this.backgroundColor = const Color(0x12FFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
          ],
          if (icon != null) ...[
            Icon(icon, size: 11, color: AppColors.accent),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label.toUpperCase(),
              style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textPrimary)
                  .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.8),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
