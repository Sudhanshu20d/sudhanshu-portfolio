import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SectionTitle extends StatelessWidget {
  final String number;
  final String title;
  final String? subtitle;
  final bool isItalic;
  final CrossAxisAlignment crossAxisAlignment;

  const SectionTitle({
    super.key,
    required this.number,
    required this.title,
    this.subtitle,
    this.isItalic = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 1,
              color: AppColors.accent,
            ),
            const SizedBox(width: 8),
            Text(
              number,
              style: AppTypography.monoNumber(fontSize: 13, color: AppColors.accent),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTypography.sectionTitle(
            fontSize: isMobile ? 34 : 46,
            italic: isItalic,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              style: AppTypography.bodyMedium(color: AppColors.textMuted),
            ),
          ),
        ],
      ],
    );
  }
}
