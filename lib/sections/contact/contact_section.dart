import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isTalkHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Error launching url $url: $e');
    }
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: PortfolioData.email));
    setState(() => _copied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Email copied to clipboard (${PortfolioData.email})',
          style: AppTypography.monoLabel(color: const Color(0xFF0B0B0E)).copyWith(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isTiny = screenWidth < 360;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isTiny ? 16.0 : 20.0) : 48.0,
        vertical: isMobile ? 48.0 : 96.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hairline Rule above
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.hairline,
          ),

          SizedBox(height: isMobile ? 28 : 48),

          // Small Technical Label: 06 — CONTACT
          Row(
            children: [
              Text(
                '06 — CONTACT',
                style: AppTypography.monoNumber(
                  fontSize: 12,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 32 : 56),

          // Huge Typographic Headline:
          // Have an idea
          // worth building?
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Have an idea',
                  style: AppTypography.displayHeading(
                    fontSize: isMobile ? 48 : 84,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -2.0,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'worth building?',
                  style: AppTypography.editorialItalic(
                    fontSize: isMobile ? 48 : 84,
                    color: AppColors.accent,
                    height: 1.05,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 36 : 56),

          // "Let's talk →" with subtle lime underline
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isTalkHovered = true),
            onExit: (_) => setState(() => _isTalkHovered = false),
            child: GestureDetector(
              onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _isTalkHovered ? AppColors.accent : AppColors.accent.withValues(alpha: 0.6),
                      width: 2.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Let's talk →",
                      style: AppTypography.displayHeading(
                        fontSize: isMobile ? 24 : 36,
                        color: _isTalkHovered ? AppColors.accent : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 28 : 44),

          // Direct Email Address (Click to mail / copy)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _copyEmail,
              child: Container(
                constraints: BoxConstraints(maxWidth: isMobile ? screenWidth - 36 : 460),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(
                    color: _copied ? AppColors.accent : AppColors.hairline,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        PortfolioData.email,
                        style: AppTypography.monoLabel(
                          fontSize: isMobile ? 11.5 : 14,
                          color: AppColors.textPrimary,
                        ).copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _copied ? '[ COPIED ]' : '[ COPY ]',
                      style: AppTypography.monoNumber(
                        fontSize: 10,
                        color: _copied ? AppColors.accent : AppColors.textDim,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 40 : 64),

          // Social Links: GITHUB, LINKEDIN, INSTAGRAM, X
          Wrap(
            spacing: isMobile ? 20 : 36,
            runSpacing: 16,
            children: [
              _MinimalSocialLink(
                label: 'GITHUB',
                onTap: () => _launchUrl(PortfolioData.githubUrl),
              ),
              _MinimalSocialLink(
                label: 'LINKEDIN',
                onTap: () => _launchUrl(PortfolioData.linkedinUrl),
              ),
              _MinimalSocialLink(
                label: 'INSTAGRAM',
                onTap: () => _launchUrl(PortfolioData.instagramUrl),
              ),
              _MinimalSocialLink(
                label: 'X',
                onTap: () => _launchUrl(PortfolioData.twitterUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MinimalSocialLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _MinimalSocialLink({
    required this.label,
    required this.onTap,
  });

  @override
  State<_MinimalSocialLink> createState() => _MinimalSocialLinkState();
}

class _MinimalSocialLinkState extends State<_MinimalSocialLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: AppTypography.monoLabel(
                fontSize: 12,
                color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                letterSpacing: 1.5,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 4),
            Text(
              '↗',
              style: AppTypography.monoNumber(
                fontSize: 12,
                color: _isHovered ? AppColors.accent : AppColors.textDim,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
