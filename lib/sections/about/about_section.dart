import '../../core/widgets/luxury_badge.dart';
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 960;
    final isTiny = screenWidth < 360;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isTiny ? 16.0 : 20.0) : 48.0,
        vertical: isMobile ? 32.0 : 64.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading: 03  About
          SectionTitle(number: '03', title: 'About', subtitle: null),

          SizedBox(height: isMobile ? 32 : 56),

          // Two-column editorial layout matching Screenshot 2
          if (isMobile)
            _buildMobileLayout(context)
          else
            _buildDesktopLayout(context),
          SizedBox(height: 32),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: PortfolioData.skills
                .map((skill) => LuxuryBadge(label: skill['name'] as String))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _statement(double size) => Text.rich(
    TextSpan(
      children: [
        TextSpan(text: 'A '),
        TextSpan(
          text: 'Flutter',
          style: TextStyle(color: AppColors.accent),
        ),
        TextSpan(
          text:
              ' developer from Vapi, Gujarat, who cares about how an app feels once it’s in someone’s hand.',
        ),
      ],
    ),
    style: AppTypography.displayHeading(
      fontSize: size,
      height: 1.1,
      letterSpacing: -size * 0.05,
    ),
  );

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: EDITORIAL NOTE / FIG. 02 — WORKING PORTRAIT
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EDITORIAL NOTE',
                    style: AppTypography.monoLabel(
                      fontSize: 11,
                      color: AppColors.textDim,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'FIG. 02 — WORKING PORTRAIT',
                    style: AppTypography.monoLabel(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      letterSpacing: 1.5,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 28),

                  // Technical note / philosophy block
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.hairline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CORE DISCIPLINES',
                          style: AppTypography.monoNumber(
                            fontSize: 10,
                            color: AppColors.accent,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildDisciplineItem(
                          '01',
                          'Cross-Platform Dart & Flutter Engine',
                        ),
                        _buildDisciplineItem(
                          '02',
                          'State Architecture (BLoC & Provider)',
                        ),
                        _buildDisciplineItem(
                          '03',
                          'Offline Persistence (Hive & SQLite)',
                        ),
                        _buildDisciplineItem(
                          '04',
                          'Production Store Deployment (Play & iOS)',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 56),

            // Right Column: Large Quote + Narrative Bio
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large quote in Newsreader italic serif
                  _statement(52),

                  SizedBox(height: 28),

                  // Factual Bio
                  Text(
                    PortfolioData.aboutBio,
                    style: AppTypography.bodyLarge(
                      color: AppColors.textMuted,
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 64),

        // Specs Row / Metadata Table (ROLE, BASED, EDUCATION, CURRENT LAB)
        _buildMetadataSpecsRow(isMobile: false),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Editorial note header
        Text(
          'EDITORIAL NOTE\nFIG. 02 — WORKING PORTRAIT',
          style: AppTypography.monoLabel(
            fontSize: 10.5,
            color: AppColors.textDim,
            letterSpacing: 1.5,
          ),
        ),

        SizedBox(height: 20),

        // Large Quote
        _statement(32),

        SizedBox(height: 20),

        // Bio paragraph
        Text(
          PortfolioData.aboutBio,
          style: AppTypography.bodyMedium(
            color: AppColors.textMuted,
            height: 1.6,
          ),
        ),

        SizedBox(height: 32),

        // Mobile Specs
        _buildMetadataSpecsRow(isMobile: true),
      ],
    );
  }

  Widget _buildMetadataSpecsRow({required bool isMobile}) {
    final specs = [
      {'label': 'ROLE', 'value': 'Flutter Developer'},
      {'label': 'BASED', 'value': 'Vapi / Gujarat, India'},
      {'label': 'EDUCATION', 'value': 'BCA Graduate'},
      {'label': 'CURRENT LAB', 'value': PortfolioData.company},
    ];

    if (isMobile) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.hairline),
            bottom: BorderSide(color: AppColors.hairline),
          ),
        ),
        child: Wrap(
          runSpacing: 20,
          spacing: 24,
          children: specs.map((s) {
            return SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['label']!,
                    style: AppTypography.monoLabel(
                      fontSize: 10,
                      color: AppColors.textDim,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    s['value']!,
                    style: AppTypography.bodySmall(
                      color: AppColors.textPrimary,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.hairline),
          bottom: BorderSide(color: AppColors.hairline),
        ),
      ),
      child: Row(
        children: specs.map((s) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s['label']!,
                  style: AppTypography.monoLabel(
                    fontSize: 10.5,
                    color: AppColors.textDim,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  s['value']!,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDisciplineItem(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: AppTypography.monoNumber(
              fontSize: 10,
              color: AppColors.accent,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
