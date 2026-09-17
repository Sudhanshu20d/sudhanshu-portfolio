import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'luxury_badge.dart';
import 'magnetic_button.dart';

class ResumeModal extends StatelessWidget {
  const ResumeModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => const ResumeModal(),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF111116),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppColors.borderLight, width: 1.2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 580),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF161622),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.accent, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            PortfolioData.monogram,
                            style: AppTypography.monoNumber(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PortfolioData.name,
                            style: AppTypography.cardTitle(fontSize: 20),
                          ),
                          Text(
                            'Curriculum Vitae • 2026',
                            style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(height: 1, color: AppColors.border),
              const SizedBox(height: 20),

              Text(
                'ROLE & SPECIALIZATION',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textMuted),
              ),
              const SizedBox(height: 6),
              Text(
                '${PortfolioData.role} at ${PortfolioData.company}',
                style: AppTypography.bodyMedium(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                PortfolioData.location,
                style: AppTypography.monoLabel(fontSize: 12, color: AppColors.accent),
              ),

              const SizedBox(height: 18),

              Text(
                'SUMMARY',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textMuted),
              ),
              const SizedBox(height: 6),
              Text(
                PortfolioData.aboutStatement,
                style: AppTypography.bodySmall(color: const Color(0xFFD6D4CE)),
              ),

              const SizedBox(height: 20),

              Text(
                'VERIFIED CORE COMPETENCIES',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: const [
                  LuxuryBadge(label: 'Flutter & Dart'),
                  LuxuryBadge(label: 'Bloc & Provider'),
                  LuxuryBadge(label: 'REST APIs'),
                  LuxuryBadge(label: 'Hive & SQLite'),
                  LuxuryBadge(label: 'Clean Architecture'),
                  LuxuryBadge(label: 'Git & GitHub'),
                ],
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: MagneticButton(
                      text: 'View GitHub Profile',
                      icon: Icons.open_in_new_rounded,
                      style: MagneticButtonStyle.primary,
                      onTap: () {
                        Navigator.of(context).pop();
                        _launchUrl(PortfolioData.githubUrl);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MagneticButton(
                      text: 'Direct Email',
                      icon: Icons.mail_outline_rounded,
                      style: MagneticButtonStyle.secondary,
                      onTap: () {
                        Navigator.of(context).pop();
                        _launchUrl('mailto:${PortfolioData.email}');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
