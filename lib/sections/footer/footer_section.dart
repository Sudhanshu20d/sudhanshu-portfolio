import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onScrollToTop;
  final Function(String)? onNavTap;

  const FooterSection({
    super.key,
    required this.onScrollToTop,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 880;
    final isTiny = screenWidth < 360;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isTiny ? 16.0 : 20.0) : 48.0,
        vertical: 40.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.hairline, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: SD Monogram, Identity, Back to Top
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            runSpacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${PortfolioData.monogram}.',
                    style: AppTypography.displayHeading(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    PortfolioData.name,
                    style: AppTypography.bodyMedium(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'FLUTTER DEVELOPER',
                    style: AppTypography.monoLabel(
                      fontSize: 10,
                      color: AppColors.accent,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),

              // Back to Top Link
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onScrollToTop,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'BACK TO TOP',
                        style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '↑',
                        style: AppTypography.monoNumber(fontSize: 13, color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Bottom Editorial Ledger
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 12,
            children: [
              Text(
                '© 2026 SUDHANSHU SINGH. ALL RIGHTS RESERVED.',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textDim),
              ),
              const SizedBox(width: 20),
              Text(
                'ENGINEERED WITH FLUTTER WEB',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textDim),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
