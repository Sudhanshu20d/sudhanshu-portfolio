import 'dart:ui';
import '../../core/widgets/accessible_action.dart';
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
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: AccessibleAction(
                      onTap: onOpenMenu,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${PortfolioData.monogram}.',
                            style: AppTypography.displayHeading(
                              fontSize: 24,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PortfolioData.name,
                                style: AppTypography.bodySmall(
                                  color: AppColors.textPrimary,
                                ).copyWith(fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'FLUTTER DEVELOPER',
                                style: AppTypography.monoLabel(
                                  fontSize: 8,
                                  letterSpacing: 0.4,
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
              const SizedBox(width: 12),
              SizedBox(
                height: 40,
                child: AccessibleAction(
                  onTap: onResumeTap,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Text(
                      'RESUME ↗',
                      style: AppTypography.monoLabel(
                        fontSize: 10,
                        letterSpacing: 0.6,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 44,
                height: 44,
                child: IconButton(
                  tooltip: 'Open navigation',
                  padding: EdgeInsets.zero,
                  onPressed: onOpenMenu,
                  icon: Icon(
                    Icons.menu_rounded,
                    color: AppColors.textPrimary,
                    size: 26,
                  ),
                ),
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
          // Frosted Backdrop Tap to Close
          GestureDetector(
            excludeFromSemantics: true,
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
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drawer Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'INDEX / NAVIGATION',
                          style: AppTypography.monoNumber(
                            fontSize: 11,
                            color: AppColors.accent,
                          ),
                        ),
                        SizedBox(
                          width: 44,
                          height: 44,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: onClose,
                            icon: Icon(
                              Icons.close_rounded,
                              color: AppColors.textPrimary,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),

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

                    SizedBox(height: 28),

                    // Bottom Dossier Panel
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.hairline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SUDHANSHU SINGH',
                            style: AppTypography.monoLabel(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${PortfolioData.company} • ${PortfolioData.location}',
                            style: AppTypography.monoLabel(
                              fontSize: 10.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                          SizedBox(height: 16),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: AccessibleAction(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                onClose();
                                onResumeTap();
                              },
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(minHeight: 44),
                                padding: EdgeInsets.symmetric(vertical: 12),
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
      padding: EdgeInsets.symmetric(vertical: 10),
      child: AccessibleAction(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          children: [
            Text(
              number,
              style: AppTypography.monoNumber(
                fontSize: 12,
                color: AppColors.accent,
              ),
            ),
            SizedBox(width: 14),
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
