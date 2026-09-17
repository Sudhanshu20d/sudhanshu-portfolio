import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/luxury_badge.dart';
import '../../core/widgets/magnetic_button.dart';

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

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _breathingController;

  late final Animation<double> _monogramOpacity;
  late final Animation<double> _lineGrowth;
  late final Animation<double> _overlayFadeOut;
  late final Animation<double> _contentFadeIn;
  late final Animation<double> _nameSlide;
  late final Animation<double> _portraitBlur;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    // Intro choreography
    _monogramOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );

    _lineGrowth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.2, 0.45, curve: Curves.easeInOutCubic),
      ),
    );

    _overlayFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.45, 0.70, curve: Curves.easeInOut),
      ),
    );

    _contentFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.55, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    _nameSlide = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.55, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    _portraitBlur = Tween<double>(begin: 16.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
      ),
    );

    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    return SizedBox(
      height: isMobile ? null : math.max(760.0, size.height - 76),
      width: double.infinity,
      child: Stack(
        children: [
          // Main Content
          AnimatedBuilder(
            animation: _introController,
            builder: (context, _) {
              return Opacity(
                opacity: _contentFadeIn.value,
                child: Transform.translate(
                  offset: Offset(0, _nameSlide.value),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: isMobile ? 24.0 : 54.0,
                        right: isMobile ? 24.0 : 54.0,
                        top: isMobile ? 32.0 : 64.0,
                        bottom: isMobile ? 32.0 : 20.0,
                      ),
                      child: isMobile ? _buildMobileLayout(size) : _buildDesktopLayout(size),
                    ),
                  ),
                ),
              );
            },
          ),

          // Apple Keynote Intro Curtain / Monogram Overlay
          AnimatedBuilder(
            animation: _introController,
            builder: (context, _) {
              if (_overlayFadeOut.value <= 0.001) {
                return const SizedBox.shrink();
              }
              return IgnorePointer(
                child: Opacity(
                  opacity: _overlayFadeOut.value,
                  child: Container(
                    color: AppColors.background,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Opacity(
                            opacity: _monogramOpacity.value,
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: const Color(0xFF16161F),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.accent, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withValues(alpha: 0.35),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  PortfolioData.monogram,
                                  style: AppTypography.monoNumber(
                                    fontSize: 20,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            height: 1.5,
                            width: 220 * _lineGrowth.value,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.accent,
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(Size size) {
    // Calculate mouse parallax offset safely
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final mouseOffsetX = (widget.mousePosition.dx - centerX) / centerX;
    final mouseOffsetY = (widget.mousePosition.dy - centerY) / centerY;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Editorial Huge Typography & CTAs
        Expanded(
          flex: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Metadata Pills row
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  const LuxuryBadge(
                    label: 'Available for Freelance',
                    dotColor: AppColors.liveGreen,
                  ),
                  LuxuryBadge(label: PortfolioData.heroPills[0]), // Flutter Developer
                  LuxuryBadge(label: PortfolioData.heroPills[1]), // Vapi / Gujarat / India
                  LuxuryBadge(label: PortfolioData.heroPills[3]), // 2026 Portfolio
                ],
              ),

              const SizedBox(height: 32),

              // Huge Editorial Typography: SUDHANSHU SINGH
              // Using responsive sizing so it never causes overflows
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUDHANSHU',
                      style: AppTypography.heroTitle(fontSize: 106, italic: false),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SINGH',
                          style: AppTypography.heroTitle(fontSize: 106, italic: true)
                              .copyWith(color: AppColors.accent),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 48,
                          height: 2,
                          color: AppColors.borderLight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Sub-lead statement
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Text(
                  'Flutter Developer • Mobile App Developer based in Vapi, Gujarat. Building fast, production-grade applications with clean architecture and refined motion.',
                  style: AppTypography.bodyLarge(height: 1.6),
                ),
              ),

              const SizedBox(height: 36),

              // CTA Buttons
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  MagneticButton(
                    text: 'View Projects',
                    icon: Icons.arrow_downward_rounded,
                    style: MagneticButtonStyle.primary,
                    onTap: widget.onViewProjectsTap,
                  ),
                  MagneticButton(
                    text: 'Download Resume',
                    icon: Icons.download_rounded,
                    style: MagneticButtonStyle.secondary,
                    onTap: widget.onResumeTap,
                  ),
                  MagneticButton(
                    text: 'GitHub',
                    icon: Icons.open_in_new_rounded,
                    style: MagneticButtonStyle.outline,
                    onTap: widget.onGithubTap,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 40),

        // Right Column: Floating Portrait Frame (DOES NOT OVERLAP TEXT)
        Expanded(
          flex: 10,
          child: Center(
            child: _buildPortraitWidget(
              mouseOffsetX: mouseOffsetX,
              mouseOffsetY: mouseOffsetY,
              width: 390,
              height: 520,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Metadata Pills
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            const LuxuryBadge(
              label: 'Available for Freelance',
              dotColor: AppColors.liveGreen,
            ),
            LuxuryBadge(label: PortfolioData.heroPills[0]),
            LuxuryBadge(label: PortfolioData.heroPills[1]),
          ],
        ),

        const SizedBox(height: 24),

        // Mobile Typography (Never covered by portrait, scales perfectly)
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SUDHANSHU',
                style: AppTypography.heroTitle(fontSize: 52, italic: false),
              ),
              Text(
                'SINGH',
                style: AppTypography.heroTitle(fontSize: 52, italic: true)
                    .copyWith(color: AppColors.accent),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'Flutter Developer • Mobile App Developer at RND Technosoft. Building fast, responsive applications.',
          style: AppTypography.bodyMedium(),
        ),

        const SizedBox(height: 24),

        // Mobile CTAs
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            MagneticButton(
              text: 'View Projects',
              icon: Icons.arrow_downward_rounded,
              isSmall: true,
              style: MagneticButtonStyle.primary,
              onTap: widget.onViewProjectsTap,
            ),
            MagneticButton(
              text: 'Download Resume',
              icon: Icons.download_rounded,
              isSmall: true,
              style: MagneticButtonStyle.secondary,
              onTap: widget.onResumeTap,
            ),
          ],
        ),

        const SizedBox(height: 36),

        // Portrait fills width nicely on mobile with zero text overlap
        Center(
          child: _buildPortraitWidget(
            mouseOffsetX: 0,
            mouseOffsetY: 0,
            width: math.min(size.width - 48, 340), // 24px padding on each side
            height: math.min(size.width - 48, 340) * 1.25,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPortraitWidget({
    required double mouseOffsetX,
    required double mouseOffsetY,
    required double width,
    required double height,
  }) {
    return AnimatedBuilder(
      animation: Listenable.merge([_breathingController, _introController]),
      builder: (context, _) {
        // Slow subtle breathing zoom (scale 1.0 to 1.03)
        final breathingScale = 1.0 + (_breathingController.value * 0.03);

        // Mouse parallax translation
        final parallaxX = mouseOffsetX * 14.0;
        final parallaxY = mouseOffsetY * 14.0;

        return Transform.translate(
          offset: Offset(parallaxX, parallaxY),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0x28FFFFFF),
                width: 1.2,
              ),
              boxShadow: [
                // Soft ambient violet spotlight glow
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.18),
                  blurRadius: 50,
                  spreadRadius: 4,
                  offset: const Offset(0, 16),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.8),
                  blurRadius: 36,
                  offset: const Offset(0, 24),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Portrait Image with breathing zoom
                  Transform.scale(
                    scale: breathingScale,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      PortfolioData.portraitAsset,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF14141A),
                          child: const Center(
                            child: Icon(Icons.person, size: 72, color: AppColors.textDim),
                          ),
                        );
                      },
                    ),
                  ),

                  // Blur removal transition during intro
                  if (_portraitBlur.value > 0.1)
                    Container(
                      color: AppColors.background.withValues(alpha: (_portraitBlur.value / 16.0) * 0.8),
                    ),

                  // Subtle luxury vignette gradient at bottom of frame
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.65),
                            ],
                            stops: const [0.0, 0.65, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Subtle corner badge on frame
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xCC09090C),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderLight, width: 0.8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'SUDHANSHU SINGH',
                                style: AppTypography.monoLabel(
                                  fontSize: 11,
                                  color: AppColors.textPrimary,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                PortfolioData.company,
                                style: AppTypography.monoLabel(
                                  fontSize: 10,
                                  color: AppColors.accent,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0x20A88CFF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'VAPI, IN',
                              style: AppTypography.monoNumber(fontSize: 10, color: AppColors.accent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
