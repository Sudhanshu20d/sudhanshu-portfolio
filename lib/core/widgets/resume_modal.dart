import 'accessible_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'luxury_badge.dart';
import 'magnetic_button.dart';

class ResumeModal extends StatelessWidget {
  const ResumeModal({super.key});

  static void show(BuildContext context) {
    if (kIsWeb) {
      launchUrl(Uri.base.resolve('resume.html'), webOnlyWindowName: '_self');
      return;
    }
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => ResumeModal(),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.borderLight, width: 1.0),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 560),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.accent,
                              width: 1,
                            ),
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
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PortfolioData.name,
                                style: AppTypography.cardTitle(fontSize: 19),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'RESUME • 2026',
                                style: AppTypography.monoLabel(
                                  fontSize: 10.5,
                                  color: AppColors.accent,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textMuted,
                      size: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(height: 1, color: AppColors.hairline),
              SizedBox(height: 18),

              Text(
                'ROLE & SPECIALIZATION',
                style: AppTypography.monoLabel(
                  fontSize: 9.5,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${PortfolioData.role} at ${PortfolioData.company}',
                style: AppTypography.bodyMedium(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3),
              Text(
                PortfolioData.location,
                style: AppTypography.monoLabel(
                  fontSize: 11,
                  color: AppColors.accent,
                ),
              ),

              SizedBox(height: 16),

              Text(
                'SUMMARY',
                style: AppTypography.monoLabel(
                  fontSize: 9.5,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 5),
              Text(
                PortfolioData.aboutStatement,
                style: AppTypography.bodySmall(color: AppColors.textPrimary),
              ),

              SizedBox(height: 18),

              Text(
                'VERIFIED CORE COMPETENCIES',
                style: AppTypography.monoLabel(
                  fontSize: 9.5,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  LuxuryBadge(label: 'Flutter & Dart'),
                  LuxuryBadge(label: 'Bloc & Provider'),
                  LuxuryBadge(label: 'REST APIs'),
                  LuxuryBadge(label: 'Hive & SQLite'),
                  LuxuryBadge(label: 'Clean Architecture'),
                  LuxuryBadge(label: 'Git & GitHub'),
                ],
              ),

              SizedBox(height: 24),

              // Direct Resume PDF Action Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AccessibleAction(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _launchUrl(PortfolioData.resumeUrl),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 44),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      border: Border.all(color: AppColors.accent, width: 1.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'DOWNLOAD RESUME PDF ↗',
                      style: AppTypography.monoLabel(
                        fontSize: 12,
                        color: AppColors.accent,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),

              if (isMobile)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
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
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
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
                )
              else
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
                    SizedBox(width: 12),
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
