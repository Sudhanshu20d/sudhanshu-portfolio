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
        // Top Hairline Rule
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.hairline,
        ),
        SizedBox(height: isMobile ? 24 : 36),

        // Editorial Heading: e.g. "02  Selected projects"
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              number,
              style: AppTypography.monoNumber(
                fontSize: isMobile ? 13 : 16,
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: isMobile ? 12 : 18),
            Flexible(
              child: Text(
                title,
                style: AppTypography.sectionTitle(
                  fontSize: isMobile ? (screenWidth < 360 ? 30 : 38) : 56,
                  italic: isItalic,
                ),
              ),
            ),
          ],
        ),

        // Editorial Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              subtitle!,
              style: AppTypography.bodyLarge(
                color: AppColors.textMuted,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
