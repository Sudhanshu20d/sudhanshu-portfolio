import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/luxury_badge.dart';
import '../../core/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    final technologies = [
      'Flutter',
      'Dart',
      'Firebase',
      'REST APIs',
      'State Management',
      'Responsive UI',
      'Clean Architecture',
      'Git',
      'Android',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 54.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            number: '01 / PHILOSOPHY',
            title: 'About The Craft',
            isItalic: true,
          ),
          const SizedBox(height: 48),

          // Editorial Split Layout
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLargeStatement(),
                const SizedBox(height: 32),
                _buildStoryAndBadges(technologies),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildLargeStatement(),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 5,
                  child: _buildStoryAndBadges(technologies),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLargeStatement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 2,
          color: AppColors.accent,
        ),
        const SizedBox(height: 24),
        Text(
          PortfolioData.aboutStatement,
          style: AppTypography.cardTitle(fontSize: 32, italic: false).copyWith(
            height: 1.35,
            color: AppColors.textPrimary,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF131318),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0x20A88CFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.code_rounded, color: AppColors.accent, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BASED IN GUJARAT',
                      style: AppTypography.monoLabel(fontSize: 10, color: AppColors.accent),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${PortfolioData.company} • ${PortfolioData.location}',
                      style: AppTypography.bodySmall(color: AppColors.textPrimary)
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStoryAndBadges(List<String> technologies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.aboutBio,
          style: AppTypography.bodyLarge(color: AppColors.textMuted, height: 1.7),
        ),
        const SizedBox(height: 28),
        Text(
          'CORE CAPABILITIES & TOOLS',
          style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: technologies.map((tech) {
            return LuxuryBadge(
              label: tech,
              backgroundColor: const Color(0xFF14141A),
              borderColor: AppColors.borderLight,
            );
          }).toList(),
        ),
      ],
    );
  }
}
