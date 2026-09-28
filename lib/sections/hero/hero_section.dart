import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class DiagonalTexturePainter extends CustomPainter {
  final Color color;
  final double spacing;

  const DiagonalTexturePainter({
    this.color = const Color(0x0EFFFFFF),
    this.spacing = 18.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    for (double i = -size.height; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HeroSection extends StatefulWidget {
  final Offset mousePosition;
  final VoidCallback onViewProjectsTap;
  final VoidCallback onResumeTap;
  final VoidCallback onGithubTap;

  const HeroSection({
    super.key,
    required this.mousePosition,
    required this.onViewProjectsTap,
    required this.onResumeTap,
    required this.onGithubTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _revealController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _revealController,
        curve: Curves.easeOutCubic,
      ),
    );

    _revealController.forward();
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;
    final isTinyMobile = size.width < 360;

    return AnimatedBuilder(
      animation: _revealController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? (isTinyMobile ? 16.0 : 20.0) : 48.0,
          vertical: isMobile ? 24.0 : 48.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top technical label: PORTFOLIO — SUDHANSHU SINGH — VAPI, GUJARAT, INDIA
            Row(
              children: [
                Flexible(
                  child: Text(
                    'PORTFOLIO — SUDHANSHU SINGH — ${PortfolioData.location.toUpperCase()}',
                    style: AppTypography.monoLabel(
                      fontSize: isMobile ? 10.5 : 12,
                      color: AppColors.textMuted,
                      letterSpacing: 2.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: isMobile ? 28 : 44),

            // Main Hero Editorial Composition
            if (isMobile)
              _buildMobileComposition(size)
            else
              _buildDesktopComposition(size),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopComposition(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Huge Typographic Statement + Editorial Copy
        Expanded(
          flex: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Huge Headline:
              // Sudhanshu
              // Singh Flutter Developer
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sudhanshu',
                      style: AppTypography.displayHeading(
                        fontSize: 92,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -2.5,
                        height: 0.95,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Singh',
                          style: AppTypography.displayHeading(
                            fontSize: 92,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            letterSpacing: -2.5,
                            height: 0.95,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Text(
                          'Flutter Developer',
                          style: AppTypography.editorialItalic(
                            fontSize: 48,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Editorial Tagline in Newsreader Italic
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(
                  'Building mobile products that people actually use.',
                  style: AppTypography.editorialItalic(
                    fontSize: 32,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Editorial Body Subtext
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  'I build and ship Flutter apps for Android and iOS — focused on performance, clean architecture, and fluid 60fps native feel.',
                  style: AppTypography.bodyLarge(
                    color: AppColors.textMuted,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Rectangular Editorial Buttons
              Wrap(
                spacing: 14,
                runSpacing: 12,
                children: [
                  _EditorialRectButton(
                    text: 'View Projects ↓',
                    isPrimary: true,
                    onTap: widget.onViewProjectsTap,
                  ),
                  _EditorialRectButton(
                    text: 'RESUME ↗',
                    isPrimary: false,
                    onTap: widget.onResumeTap,
                  ),
                  _EditorialRectButton(
                    text: 'GitHub ↗',
                    isPrimary: false,
                    onTap: widget.onGithubTap,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right Column: Framed Editorial Portrait with Diagonal Texture
        Expanded(
          flex: 8,
          child: _buildPortraitDossier(
            width: 380,
            height: 490,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileComposition(Size size) {
    final screenWidth = size.width;
    final cardWidth = math.min(screenWidth - 40, 360.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Huge Scaled Headline
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sudhanshu',
                style: AppTypography.displayHeading(
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -1.5,
                  height: 0.95,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Singh',
                style: AppTypography.displayHeading(
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -1.5,
                  height: 0.95,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Flutter Developer',
                style: AppTypography.editorialItalic(
                  fontSize: 32,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Editorial Tagline
        Text(
          'Building mobile products that people actually use.',
          style: AppTypography.editorialItalic(
            fontSize: screenWidth < 360 ? 22 : 25,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 14),

        // Body Subtext
        Text(
          'I build and ship Flutter apps for Android and iOS — focused on performance, clean architecture, and fluid 60fps native feel.',
          style: AppTypography.bodyMedium(height: 1.55),
        ),

        const SizedBox(height: 24),

        // Action Buttons
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            _EditorialRectButton(
              text: 'View Projects ↓',
              isPrimary: true,
              onTap: widget.onViewProjectsTap,
            ),
            _EditorialRectButton(
              text: 'RESUME ↗',
              isPrimary: false,
              onTap: widget.onResumeTap,
            ),
            _EditorialRectButton(
              text: 'GitHub ↗',
              isPrimary: false,
              onTap: widget.onGithubTap,
            ),
          ],
        ),

        const SizedBox(height: 36),

        // Centered Real Portrait Frame
        Center(
          child: _buildPortraitDossier(
            width: cardWidth,
            height: cardWidth * 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitDossier({
    required double width,
    required double height,
  }) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.hairline, width: 1.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Subtle diagonal texture in background
            Positioned.fill(
              child: CustomPaint(
                painter: const DiagonalTexturePainter(),
              ),
            ),

            // Real Portrait Asset - Clean editorial presentation with no distracting labels
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, width: 0.8),
                ),
                child: ClipRect(
                  child: Image.asset(
                    PortfolioData.portraitAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surfaceElevated,
                        child: const Center(
                          child: Icon(Icons.person, size: 64, color: AppColors.textDim),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditorialRectButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback onTap;

  const _EditorialRectButton({
    required this.text,
    this.isPrimary = false,
    required this.onTap,
  });

  @override
  State<_EditorialRectButton> createState() => _EditorialRectButtonState();
}

class _EditorialRectButtonState extends State<_EditorialRectButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isPrimary
        ? (_isHovered ? AppColors.accent : AppColors.accent.withValues(alpha: 0.6))
        : (_isHovered ? AppColors.accent : AppColors.hairline);

    final textColor = widget.isPrimary
        ? (_isHovered ? AppColors.accent : AppColors.textPrimary)
        : (_isHovered ? AppColors.accent : AppColors.textPrimary);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceElevated : AppColors.surface,
            border: Border.all(color: borderColor, width: 1.0),
          ),
          child: Text(
            widget.text,
            style: AppTypography.monoLabel(
              fontSize: 12.5,
              color: textColor,
              letterSpacing: 0.5,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
