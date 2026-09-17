import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/magnetic_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _copied = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: PortfolioData.email));
    setState(() => _copied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Email copied to clipboard (${PortfolioData.email})',
          style: AppTypography.monoLabel(color: Colors.black),
        ),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 54.0,
        vertical: 80.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24.0 : 56.0,
          vertical: isMobile ? 40.0 : 64.0,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF101016),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.borderLight, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.06),
              blurRadius: 60,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.liveGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'OPEN FOR OPPORTUNITIES & FREELANCE',
                  style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Huge editorial headline
            Text(
              "LET'S BUILD\nSOMETHING WORTH\nSHIPPING.",
              style: AppTypography.heroTitle(
                fontSize: isMobile ? 38 : 68,
                italic: false,
              ).copyWith(letterSpacing: -1.2, height: 1.05),
            ),

            const SizedBox(height: 24),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 580),
              child: Text(
                'Available for engineering production Flutter mobile apps, state management refactors, and end-to-end product deliveries.',
                style: AppTypography.bodyLarge(),
              ),
            ),

            const SizedBox(height: 40),

            // Email Copy Pill
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _copyEmail,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161622),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _copied ? AppColors.accent : AppColors.border,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _copied ? Icons.check_circle_outline : Icons.mail_outline,
                        size: 18,
                        color: _copied ? AppColors.liveGreen : AppColors.accent,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        PortfolioData.email,
                        style: AppTypography.monoLabel(
                          fontSize: isMobile ? 12 : 14,
                          color: AppColors.textPrimary,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0x20A88CFF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _copied ? 'COPIED!' : 'CLICK TO COPY',
                          style: AppTypography.monoLabel(fontSize: 10, color: AppColors.accent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Social Morphing Buttons
            Wrap(
              spacing: 14,
              runSpacing: 12,
              children: [
                MagneticButton(
                  text: 'GitHub',
                  icon: Icons.code,
                  style: MagneticButtonStyle.primary,
                  onTap: () => _launchUrl(PortfolioData.githubUrl),
                ),
                MagneticButton(
                  text: 'LinkedIn',
                  icon: Icons.work_outline,
                  style: MagneticButtonStyle.secondary,
                  onTap: () => _launchUrl(PortfolioData.linkedinUrl),
                ),
                MagneticButton(
                  text: 'Instagram',
                  icon: Icons.camera_alt_outlined,
                  style: MagneticButtonStyle.secondary,
                  onTap: () => _launchUrl(PortfolioData.instagramUrl),
                ),
                MagneticButton(
                  text: 'Send Direct Email',
                  icon: Icons.arrow_outward_rounded,
                  style: MagneticButtonStyle.outline,
                  onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
