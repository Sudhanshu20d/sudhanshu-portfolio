import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/animations/tilt_3d_card.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/luxury_badge.dart';
import '../../core/widgets/magnetic_button.dart';
import '../../core/widgets/section_title.dart';
import '../../models/github_repo_model.dart';

class GitHubSection extends StatelessWidget {
  const GitHubSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 54.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            number: '06 / CODE',
            title: 'Open Source & Repositories',
            subtitle:
                'Public codebases and Flutter projects maintained directly on GitHub.',
            isItalic: true,
          ),
          const SizedBox(height: 48),

          // GitHub Profile Card
          Container(
            padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
            decoration: BoxDecoration(
              color: const Color(0xFF101015),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border, width: 1.2),
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.accent, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.2),
                                  blurRadius: 14,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                PortfolioData.githubAvatarAsset,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.person,
                                  color: AppColors.accent,
                                  size: 36,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              PortfolioData.githubUsername,
                              style: AppTypography.cardTitle(fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '🚀 App Developer | Flutter • Dart • Android\nPassionate about building fast, modern, and elegant mobile experiences.',
                        style: AppTypography.bodySmall(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 14),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: LuxuryBadge(
                          label: 'GITHUB PROFILE',
                          dotColor: AppColors.accent,
                          backgroundColor: Color(0x18A88CFF),
                          borderColor: Color(0x40A88CFF),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      // Avatar
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.accent, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.2),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            PortfolioData.githubAvatarAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.person,
                              color: AppColors.accent,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  PortfolioData.githubUsername,
                                  style: AppTypography.cardTitle(fontSize: 22),
                                ),
                                const SizedBox(width: 10),
                                const LuxuryBadge(
                                  label: 'GITHUB PROFILE',
                                  dotColor: AppColors.accent,
                                  backgroundColor: Color(0x18A88CFF),
                                  borderColor: Color(0x40A88CFF),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '🚀 App Developer | Flutter • Dart • Android\nPassionate about building fast, modern, and elegant mobile experiences.',
                              style: AppTypography.bodySmall(color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      MagneticButton(
                        text: 'View GitHub Profile',
                        icon: Icons.open_in_new_rounded,
                        isSmall: true,
                        style: MagneticButtonStyle.primary,
                        onTap: () => _launchUrl(PortfolioData.githubUrl),
                      ),
                    ],
                  ),
          ),

          if (isMobile) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: MagneticButton(
                text: 'View GitHub Profile',
                icon: Icons.open_in_new_rounded,
                isSmall: true,
                style: MagneticButtonStyle.primary,
                onTap: () => _launchUrl(PortfolioData.githubUrl),
              ),
            ),
          ],

          const SizedBox(height: 36),

          // Contribution Activity Aesthetic Bar
          _buildActivityBar(isMobile),

          const SizedBox(height: 36),

          // Verified Repositories Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 720;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isNarrow ? 1 : 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: isNarrow ? 1.8 : 2.1,
                ),
                itemCount: PortfolioData.githubRepos.length,
                itemBuilder: (context, index) {
                  final repo = PortfolioData.githubRepos[index];
                  return _RepoCard(
                    repo: repo,
                    onTap: () => _launchUrl(repo.url),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CONTRIBUTION ACTIVITY OVERVIEW',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.accent),
              ),
              Text(
                '10 PUBLIC REPOSITORIES',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Activity grid blocks
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(32, (colIndex) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Column(
                    children: List.generate(5, (rowIndex) {
                      // Deterministic pleasant matrix pattern
                      final activeLevel = (colIndex * 3 + rowIndex * 7) % 5;
                      Color cellColor;
                      switch (activeLevel) {
                        case 4:
                          cellColor = AppColors.accent;
                          break;
                        case 3:
                          cellColor = const Color(0xFF6352A8);
                          break;
                        case 2:
                          cellColor = const Color(0xFF372D5E);
                          break;
                        default:
                          cellColor = const Color(0xFF16161D);
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _RepoCard extends StatefulWidget {
  final GitHubRepoModel repo;
  final VoidCallback onTap;

  const _RepoCard({
    required this.repo,
    required this.onTap,
  });

  @override
  State<_RepoCard> createState() => _RepoCardState();
}

class _RepoCardState extends State<_RepoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tilt3DCard(
      maxTiltAngle: 0.05,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _isHovered ? const Color(0xFF161622) : const Color(0xFF101015),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered ? AppColors.accent.withValues(alpha: 0.5) : AppColors.border,
                width: 1.2,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    blurRadius: 24,
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark_border_rounded, size: 16, color: AppColors.accent),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.repo.name,
                              style: AppTypography.cardTitle(fontSize: 18).copyWith(
                                color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_outward_rounded, size: 16, color: AppColors.textMuted),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    widget.repo.description,
                    style: AppTypography.bodySmall(color: AppColors.textMuted),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00B4D8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.repo.language,
                      style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textPrimary),
                    ),
                    const Spacer(),
                    LuxuryBadge(
                      label: widget.repo.badge,
                      backgroundColor: const Color(0x0EFFFFFF),
                      borderColor: AppColors.border,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
