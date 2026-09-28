import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 360;

    return Container(
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.surfaceGlass : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.hairline : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: isScrolled
              ? ImageFilter.blur(sigmaX: 16, sigmaY: 16)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: SafeArea(
            bottom: false,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: isCompact ? 10 : 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: SD. Brand
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onOpenMenu(),
                      child: Text(
                        '${PortfolioData.monogram}.',
                        style: AppTypography.displayHeading(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  // Right: Actions (CV button + Hamburger)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onResumeTap,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 38),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              border: Border.all(color: AppColors.hairline),
                            ),
                            child: Text(
                              'RESUME ↗',
                              style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textPrimary),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Clean 44x44px touch target for hamburger
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: onOpenMenu,
                          icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 26),
                          splashRadius: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
          // Frosted Backdrop Tap to Close
          GestureDetector(
            onTap: onClose,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: AppColors.background.withValues(alpha: 0.95),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drawer Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'INDEX / NAVIGATION',
                        style: AppTypography.monoNumber(fontSize: 11, color: AppColors.accent),
                      ),
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: onClose,
                          icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary, size: 26),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Editorial Drawer Links
                  _DrawerLink(
                    number: '01',
                    label: 'Index',
                    onTap: () {
                      onClose();
                      onNavTap('hero');
                    },
                  ),
                  _DrawerLink(
                    number: '02',
                    label: 'Apps',
                    onTap: () {
                      onClose();
                      onNavTap('apps');
                    },
                  ),
                  _DrawerLink(
                    number: '03',
                    label: 'Projects',
                    onTap: () {
                      onClose();
                      onNavTap('projects');
                    },
                  ),
                  _DrawerLink(
                    number: '04',
                    label: 'About',
                    onTap: () {
                      onClose();
                      onNavTap('about');
                    },
                  ),
                  _DrawerLink(
                    number: '05',
                    label: 'Experience',
                    onTap: () {
                      onClose();
                      onNavTap('experience');
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

                  // Bottom Dossier Panel
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.hairline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUDHANSHU SINGH',
                          style: AppTypography.monoLabel(fontSize: 12, color: AppColors.textPrimary)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${PortfolioData.company} • ${PortfolioData.location}',
                          style: AppTypography.monoLabel(fontSize: 10.5, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 16),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              onClose();
                              onResumeTap();
                            },
                            child: Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 44),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceElevated,
                                border: Border.all(color: AppColors.hairline),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'VIEW RESUME ↗',
                                style: AppTypography.monoLabel(
                                  fontSize: 11.5,
                                  color: AppColors.textPrimary,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          children: [
            Text(
              number,
              style: AppTypography.monoNumber(fontSize: 12, color: AppColors.accent),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: AppTypography.heroTitle(fontSize: 26, italic: false),
            ),
          ],
        ),
      ),
    );
  }
}
