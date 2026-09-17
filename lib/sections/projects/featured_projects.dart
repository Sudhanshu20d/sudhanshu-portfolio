import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/luxury_badge.dart';
import '../../core/widgets/magnetic_button.dart';
import '../../core/widgets/phone_mockup.dart';
import '../../core/widgets/section_title.dart';
import '../../models/project_model.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
            number: '04 / WORK',
            title: 'Published Applications',
            subtitle:
                'Production applications live on the Google Play Store, engineered for responsive performance and intuitive mobile interaction.',
            isItalic: true,
          ),
          const SizedBox(height: 52),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.publishedProjects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 56),
            itemBuilder: (context, index) {
              final project = PortfolioData.publishedProjects[index];
              final isReversed = index % 2 != 0 && !isMobile;
              return _ProjectCard(
                project: project,
                isMobile: isMobile,
                isReversed: isReversed,
                onPlayStoreTap: project.playStoreUrl != null
                    ? () => _launchUrl(project.playStoreUrl!)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final bool isMobile;
  final bool isReversed;
  final VoidCallback? onPlayStoreTap;

  const _ProjectCard({
    required this.project,
    required this.isMobile,
    required this.isReversed,
    this.onPlayStoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final phoneWidget = Center(
      child: PhoneMockup(
        screenshots: project.screenshotAssets,
        width: isMobile ? 260 : 290,
        height: isMobile ? 520 : 570,
      ),
    );

    final infoWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App icon + Category
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.asset(
                  project.iconAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF1E1E28),
                      child: const Icon(Icons.apps, color: AppColors.accent, size: 24),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.category,
                  style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
                ),
                const SizedBox(height: 4),
                const LuxuryBadge(
                  label: 'GOOGLE PLAY STORE',
                  dotColor: AppColors.liveGreen,
                  backgroundColor: Color(0x1510B981),
                  borderColor: Color(0x3510B981),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Title
        Text(
          project.title,
          style: AppTypography.cardTitle(fontSize: isMobile ? 28 : 36),
        ),
        const SizedBox(height: 6),
        Text(
          project.subtitle,
          style: AppTypography.monoLabel(fontSize: 13, color: AppColors.textMuted),
        ),

        const SizedBox(height: 18),

        // Description
        Text(
          project.description,
          style: AppTypography.bodyMedium(height: 1.65),
        ),

        const SizedBox(height: 22),

        // Key features bullets
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
                      color: AppColors.accent,
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

        // Technologies Used
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((tech) {
            return LuxuryBadge(
              label: tech,
              backgroundColor: const Color(0x10FFFFFF),
              borderColor: AppColors.border,
            );
          }).toList(),
        ),

        const SizedBox(height: 28),

        // CTA: View on Play Store
        if (onPlayStoreTap != null)
          MagneticButton(
            text: 'View on Google Play',
            icon: Icons.open_in_new_rounded,
            style: MagneticButtonStyle.primary,
            onTap: onPlayStoreTap!,
          ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(isMobile ? 24.0 : 44.0),
      decoration: BoxDecoration(
        color: const Color(0xFF101015),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                phoneWidget,
                const SizedBox(height: 36),
                infoWidget,
              ],
            )
          : Row(
              children: [
                if (!isReversed) ...[
                  Expanded(flex: 5, child: phoneWidget),
                  const SizedBox(width: 48),
                  Expanded(flex: 7, child: infoWidget),
                ] else ...[
                  Expanded(flex: 7, child: infoWidget),
                  const SizedBox(width: 48),
                  Expanded(flex: 5, child: phoneWidget),
                ],
              ],
            ),
    );
  }
}
