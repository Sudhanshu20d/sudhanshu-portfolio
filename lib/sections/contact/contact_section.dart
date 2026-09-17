import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

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
          horizontal: isMobile ? 20.0 : 56.0,
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

            // Editorial headline
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
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 20,
                    vertical: 14,
                  ),
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
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          PortfolioData.email,
                          style: AppTypography.monoLabel(
                            fontSize: isMobile ? 12 : 14,
                            color: AppColors.textPrimary,
                          ).copyWith(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isMobile) ...[
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
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Official Social Links (GitHub, LinkedIn, Instagram, X)
            Text(
              'CONNECT',
              style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textMuted),
            ),
            const SizedBox(height: 12),

            if (isMobile)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: 'GitHub',
                          icon: FontAwesomeIcons.github,
                          isMobile: true,
                          onTap: () => _launchUrl(PortfolioData.githubUrl),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          label: 'LinkedIn',
                          icon: FontAwesomeIcons.linkedin,
                          isMobile: true,
                          onTap: () => _launchUrl(PortfolioData.linkedinUrl),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: 'Instagram',
                          icon: FontAwesomeIcons.instagram,
                          isMobile: true,
                          onTap: () => _launchUrl(PortfolioData.instagramUrl),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          label: 'X (Twitter)',
                          icon: FontAwesomeIcons.xTwitter,
                          isMobile: true,
                          onTap: () => _launchUrl(PortfolioData.twitterUrl),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Wrap(
                spacing: 14,
                runSpacing: 12,
                children: [
                  _SocialButton(
                    label: 'GitHub',
                    icon: FontAwesomeIcons.github,
                    onTap: () => _launchUrl(PortfolioData.githubUrl),
                  ),
                  _SocialButton(
                    label: 'LinkedIn',
                    icon: FontAwesomeIcons.linkedin,
                    onTap: () => _launchUrl(PortfolioData.linkedinUrl),
                  ),
                  _SocialButton(
                    label: 'Instagram',
                    icon: FontAwesomeIcons.instagram,
                    onTap: () => _launchUrl(PortfolioData.instagramUrl),
                  ),
                  _SocialButton(
                    label: 'X (Twitter)',
                    icon: FontAwesomeIcons.xTwitter,
                    onTap: () => _launchUrl(PortfolioData.twitterUrl),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final String label;
  final FaIconData icon;
  final VoidCallback onTap;
  final bool isMobile;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isMobile = false,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.accent.withValues(alpha: 0.14) : const Color(0xFF161622),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.border,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: widget.isMobile ? MainAxisSize.max : MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: _isHovered ? AppColors.accent : AppColors.textPrimary,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  widget.label,
                  style: AppTypography.buttonText(
                    color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                  ).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
