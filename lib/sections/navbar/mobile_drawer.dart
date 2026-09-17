import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/magnetic_button.dart';

class MobileNavbar extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback onOpenMenu;
  final VoidCallback onResumeTap;

  const MobileNavbar({
    super.key,
    required this.isScrolled,
    required this.onOpenMenu,
    required this.onResumeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Monogram SD
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF14141A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight, width: 1),
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
                  const SizedBox(width: 10),
                  Text(
                    'SUDHANSHU',
                    style: AppTypography.monoLabel(fontSize: 12, color: AppColors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.2),
                  ),
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MagneticButton(
                    text: 'CV',
                    icon: Icons.download_rounded,
                    isSmall: true,
                    style: MagneticButtonStyle.outline,
                    onTap: onResumeTap,
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: onOpenMenu,
                    icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 26),
                    splashRadius: 22,
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

class MobileDrawer extends StatelessWidget {
  final Function(String) onNavTap;
  final VoidCallback onClose;
  final VoidCallback onResumeTap;

  const MobileDrawer({
    super.key,
    required this.onNavTap,
    required this.onClose,
    required this.onResumeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Frosted background tap to close
          GestureDetector(
            onTap: onClose,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: AppColors.background.withValues(alpha: 0.92),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NAVIGATION',
                        style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
                      ),
                      IconButton(
                        onPressed: onClose,
                        icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  _DrawerLink(
                    number: '01',
                    label: 'About',
                    onTap: () {
                      onClose();
                      onNavTap('about');
                    },
                  ),
                  _DrawerLink(
                    number: '02',
                    label: 'Experience',
                    onTap: () {
                      onClose();
                      onNavTap('experience');
                    },
                  ),
                  _DrawerLink(
                    number: '03',
                    label: 'Skills',
                    onTap: () {
                      onClose();
                      onNavTap('skills');
                    },
                  ),
                  _DrawerLink(
                    number: '04',
                    label: 'Projects',
                    onTap: () {
                      onClose();
                      onNavTap('projects');
                    },
                  ),
                  _DrawerLink(
                    number: '05',
                    label: 'GitHub',
                    onTap: () {
                      onClose();
                      onNavTap('github');
                    },
                  ),
                  _DrawerLink(
                    number: '06',
                    label: 'Contact',
                    onTap: () {
                      onClose();
                      onNavTap('contact');
                    },
                  ),

                  const Spacer(),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0x0CFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PortfolioData.location,
                          style: AppTypography.monoLabel(fontSize: 12, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          PortfolioData.email,
                          style: AppTypography.monoLabel(fontSize: 13, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: MagneticButton(
                            text: 'Download Resume',
                            icon: Icons.download_rounded,
                            style: MagneticButtonStyle.primary,
                            onTap: () {
                              onClose();
                              onResumeTap();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  final String number;
  final String label;
  final VoidCallback onTap;

  const _DrawerLink({
    required this.number,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              number,
              style: AppTypography.monoNumber(fontSize: 13, color: AppColors.accent),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTypography.sectionTitle(fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}
