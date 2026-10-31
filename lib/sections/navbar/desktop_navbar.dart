import '../../core/widgets/accessible_action.dart';
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class DesktopNavbar extends StatelessWidget {
  final bool isScrolled;
  final String activeSection;
  final Function(String) onNavTap;
  final VoidCallback onResumeTap;

  const DesktopNavbar({
    super.key,
    required this.isScrolled,
    required this.activeSection,
    required this.onNavTap,
    required this.onResumeTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 1120 ? 24.0 : 48.0;

    return AnimatedContainer(
      duration:
          WidgetsBinding
              .instance
              .platformDispatcher
              .accessibilityFeatures
              .disableAnimations
          ? Duration.zero
          : Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.hairline : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRect(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              // Left: Minimal SD. Monogram
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AccessibleAction(
                  onTap: () => onNavTap('hero'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${PortfolioData.monogram}.',
                        style: AppTypography.displayHeading(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PortfolioData.name,
                            style: AppTypography.bodySmall(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'FLUTTER DEVELOPER',
                            style: AppTypography.monoLabel(
                              fontSize: 9,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Spacer(),

              // Right: Editorial Minimal Nav Links
              _MinimalNavLink(
                label: 'Index',
                isActive: activeSection == 'hero',
                onTap: () => onNavTap('hero'),
              ),
              SizedBox(width: screenWidth < 1120 ? 14 : 24),
              _MinimalNavLink(
                label: 'Apps',
                isActive: activeSection == 'apps',
                onTap: () => onNavTap('apps'),
              ),
              SizedBox(width: screenWidth < 1120 ? 14 : 24),
              _MinimalNavLink(
                label: 'Projects',
                isActive: activeSection == 'projects',
                onTap: () => onNavTap('projects'),
              ),
              SizedBox(width: screenWidth < 1120 ? 14 : 24),
              _MinimalNavLink(
                label: 'About',
                isActive: activeSection == 'about',
                onTap: () => onNavTap('about'),
              ),
              SizedBox(width: screenWidth < 1120 ? 14 : 24),
              _MinimalNavLink(
                label: 'Experience',
                isActive: activeSection == 'experience',
                onTap: () => onNavTap('experience'),
              ),
              SizedBox(width: screenWidth < 1120 ? 14 : 24),
              _MinimalNavLink(
                label: 'Contact',
                isActive: activeSection == 'contact',
                onTap: () => onNavTap('contact'),
              ),

              SizedBox(width: 32),

              // Rectangular Resume / CV Button
              _MinimalCvButton(onTap: onResumeTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _MinimalNavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MinimalNavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_MinimalNavLink> createState() => _MinimalNavLinkState();
}

class _MinimalNavLinkState extends State<_MinimalNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = _isHovered || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AccessibleAction(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isHighlighted ? AppColors.accent : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          child: Text(
            widget.label.toUpperCase(),
            style: AppTypography.monoLabel(
              fontSize: 11,
              letterSpacing: 0.6,
              color: isHighlighted
                  ? AppColors.textPrimary
                  : AppColors.textMuted,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _MinimalCvButton extends StatefulWidget {
  final VoidCallback onTap;
  const _MinimalCvButton({required this.onTap});

  @override
  State<_MinimalCvButton> createState() => _MinimalCvButtonState();
}

class _MinimalCvButtonState extends State<_MinimalCvButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AccessibleAction(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration:
              WidgetsBinding
                  .instance
                  .platformDispatcher
                  .accessibilityFeatures
                  .disableAnimations
              ? Duration.zero
              : Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.hairline,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'RESUME ↗',
                style: AppTypography.monoLabel(
                  fontSize: 11.5,
                  color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
