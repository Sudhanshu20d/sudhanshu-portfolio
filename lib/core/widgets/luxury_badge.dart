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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: dotColor!.withValues(alpha: 0.6),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (icon != null) ...[
            Icon(icon, size: 12, color: AppColors.accent),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textPrimary)
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
