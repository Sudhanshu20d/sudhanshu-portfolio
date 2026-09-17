import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/luxury_badge.dart';
import '../../core/widgets/phone_mockup.dart';
import '../../core/widgets/section_title.dart';
import '../../models/project_model.dart';

class PrivateProjectsSection extends StatelessWidget {
  const PrivateProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 960;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 54.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            number: '05 / PRIVATE WORK',
            title: 'Internal Production Apps',
            subtitle:
                'Commercial and distribution applications developed for operational deployment. Displayed under confidential client agreement.',
            isItalic: true,
          ),
          const SizedBox(height: 52),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.privateProjects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 48),
            itemBuilder: (context, index) {
              final project = PortfolioData.privateProjects[index];
              return _PrivateProjectCard(project: project, isMobile: isMobile);
            },
          ),
        ],
      ),
    );
  }
}

class _PrivateProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isMobile;

  const _PrivateProjectCard({
    required this.project,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final phoneWidget = Center(
      child: PhoneMockup(
        screenshots: const [],
        isPrivate: true,
        title: project.title,
        privateFeatures: project.keyFeatures,
        width: isMobile ? 260 : 280,
        height: isMobile ? 500 : 540,
      ),
    );

    final infoWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const LuxuryBadge(
              label: 'PRIVATE WORK',
              dotColor: Color(0xFFF59E0B),
              backgroundColor: Color(0x15F59E0B),
              borderColor: Color(0x35F59E0B),
            ),
            const SizedBox(width: 12),
            Text(
              project.category,
              style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textMuted),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Text(
          project.title,
          style: AppTypography.cardTitle(fontSize: isMobile ? 26 : 34),
        ),
        const SizedBox(height: 6),
        Text(
          project.subtitle,
          style: AppTypography.monoLabel(fontSize: 13, color: AppColors.accent),
        ),

        const SizedBox(height: 18),

        Text(
          project.description,
          style: AppTypography.bodyMedium(height: 1.65),
        ),

        const SizedBox(height: 24),

        Text(
          'CONFIRMED PROJECT MODULES:',
          style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
        ),
        const SizedBox(height: 12),

        // Verified features only
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: project.keyFeatures.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppTypography.bodySmall(color: const Color(0xFFD6D4CE)),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((tech) {
            return LuxuryBadge(
              label: tech,
              backgroundColor: const Color(0x0CFFFFFF),
              borderColor: AppColors.border,
            );
          }).toList(),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(isMobile ? 24.0 : 40.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F14),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x20FFFFFF), width: 1.2),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                phoneWidget,
                const SizedBox(height: 32),
                infoWidget,
              ],
            )
          : Row(
              children: [
                Expanded(flex: 5, child: phoneWidget),
                const SizedBox(width: 44),
                Expanded(flex: 7, child: infoWidget),
              ],
            ),
    );
  }
}
