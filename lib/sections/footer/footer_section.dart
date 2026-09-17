import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onScrollToTop;

  const FooterSection({
    super.key,
    required this.onScrollToTop,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 54.0,
        vertical: 40.0,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF070709),
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Monogram SD + Name
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF13131A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        PortfolioData.monogram,
                        style: AppTypography.monoNumber(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Sudhanshu Singh',
                    style: AppTypography.bodySmall(color: AppColors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              // Back to top
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onScrollToTop,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'BACK TO TOP',
                        style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_upward_rounded, size: 14, color: AppColors.accent),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2026 Sudhanshu Singh. All rights reserved.',
                style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textMuted),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.flutter_dash, size: 14, color: Color(0xFF02569B)),
                  const SizedBox(width: 6),
                  Text(
                    'Made with Flutter Web',
                    style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textMuted),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
