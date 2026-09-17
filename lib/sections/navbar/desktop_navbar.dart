import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/magnetic_button.dart';

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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      height: 76,
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.surfaceGlass : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: isScrolled
              ? ImageFilter.blur(sigmaX: 16, sigmaY: 16)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                // Monogram SD
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onNavTap('hero'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFF14141A),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.borderLight, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              PortfolioData.monogram,
                              style: AppTypography.monoNumber(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'SUDHANSHU',
                          style: AppTypography.monoLabel(fontSize: 13, color: AppColors.textPrimary)
                              .copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Nav Links
                _NavLink(
                  label: 'About',
                  isActive: activeSection == 'about',
                  onTap: () => onNavTap('about'),
                ),
                _NavLink(
                  label: 'Experience',
                  isActive: activeSection == 'experience',
                  onTap: () => onNavTap('experience'),
                ),
                _NavLink(
                  label: 'Skills',
                  isActive: activeSection == 'skills',
                  onTap: () => onNavTap('skills'),
                ),
                _NavLink(
                  label: 'Projects',
                  isActive: activeSection == 'projects',
                  onTap: () => onNavTap('projects'),
                ),
                _NavLink(
                  label: 'GitHub',
                  isActive: activeSection == 'github',
                  onTap: () => onNavTap('github'),
                ),
                _NavLink(
                  label: 'Contact',
                  isActive: activeSection == 'contact',
                  onTap: () => onNavTap('contact'),
                ),

                const SizedBox(width: 20),

                // Resume CTA button
                MagneticButton(
                  text: 'Resume',
                  icon: Icons.description_outlined,
                  isSmall: true,
                  style: MagneticButtonStyle.primary,
                  onTap: onResumeTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = _isHovered || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTypography.monoLabel(
                  fontSize: 13,
                  color: isHighlighted ? AppColors.textPrimary : AppColors.textMuted,
                ).copyWith(
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              // Underline grows from center
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                height: 1.5,
                width: isHighlighted ? 24 : 0,
                decoration: BoxDecoration(
                  color: widget.isActive ? AppColors.accent : Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
