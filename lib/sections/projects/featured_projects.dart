import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_title.dart';
import '../../models/project_model.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 960;
    final isTiny = screenWidth < 360;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isTiny ? 16.0 : 20.0) : 48.0,
        vertical: isMobile ? 32.0 : 64.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading: 01  Apps
          const SectionTitle(
            number: '01',
            title: 'Apps',
            subtitle:
                'Production mobile applications live on the stores, engineered with Flutter and clean architecture.',
          ),

          SizedBox(height: isMobile ? 36 : 64),

          // Apps Editorial Showcases
          ...PortfolioData.publishedProjects.asMap().entries.map((entry) {
            final project = entry.value;

            return Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 48.0 : 96.0),
              child: _EditorialAppBlock(
                project: project,
                isMobile: isMobile,
                onPlayStoreTap: project.playStoreUrl != null
                    ? () => _launchUrl(project.playStoreUrl!)
                    : null,
                onAppStoreTap: project.appStoreUrl != null
                    ? () => _launchUrl(project.appStoreUrl!)
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _EditorialAppBlock extends StatelessWidget {
  final ProjectModel project;
  final bool isMobile;
  final VoidCallback? onPlayStoreTap;
  final VoidCallback? onAppStoreTap;

  const _EditorialAppBlock({
    required this.project,
    required this.isMobile,
    this.onPlayStoreTap,
    this.onAppStoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hasDualStore = project.playStoreUrl != null && project.appStoreUrl != null;

    final infoWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Square Icon with thin border
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.hairline, width: 1.0),
          ),
          child: ClipRect(
            child: Image.asset(
              project.iconAsset,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text(
                  'ICON',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 10,
                    color: AppColors.textDim,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Monospace Platform Tags: ANDROID   IOS
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              hasDualStore ? 'ANDROID    IOS' : 'ANDROID',
              style: AppTypography.monoLabel(
                fontSize: 11,
                color: AppColors.accent,
                letterSpacing: 2.0,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Giant Bold Sans Title
        Text(
          project.title,
          style: AppTypography.displayHeading(
            fontSize: isMobile ? (screenWidth < 360 ? 30 : 36) : 48,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.2,
            height: 1.02,
          ),
        ),

        const SizedBox(height: 16),

        // Short Editorial Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            project.description,
            style: AppTypography.bodyLarge(
              color: AppColors.textMuted,
              height: 1.55,
            ),
          ),
        ),

        const SizedBox(height: 28),

        // Rectangular Minimal Action Buttons: [ Google Play ↗ ]  [ App Store ↗ ]
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            if (onPlayStoreTap != null)
              _RectAppButton(
                text: 'Google Play ↗',
                onTap: onPlayStoreTap!,
              ),
            if (onAppStoreTap != null)
              _RectAppButton(
                text: 'App Store ↗',
                onTap: onAppStoreTap!,
              ),
          ],
        ),
      ],
    );

    // Screenshots Widget
    final screenshotsWidget = _buildScreenshotsLayout(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoWidget,
          const SizedBox(height: 32),
          screenshotsWidget,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: App details and controls
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: infoWidget,
          ),
        ),

        const SizedBox(width: 48),

        // Right Column: Staggered tall vertical phone screenshot mockups
        Expanded(
          flex: 7,
          child: screenshotsWidget,
        ),
      ],
    );
  }

  Widget _buildScreenshotsLayout(BuildContext context) {
    final screenshots = project.screenshotAssets;
    if (screenshots.isEmpty) return const SizedBox.shrink();

    if (isMobile) {
      // Horizontal scroll on mobile to avoid overflow and allow full viewing
      return SizedBox(
        height: 380,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: math.min(screenshots.length, 3),
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final offset = index == 1 ? 24.0 : (index == 2 ? 12.0 : 0.0);
            return Padding(
              padding: EdgeInsets.only(top: offset),
              child: _TallScreenshotFrame(
                imageAsset: screenshots[index],
                width: 180,
                height: 350,
                index: index + 1,
              ),
            );
          },
        ),
      );
    }

    // Desktop: 3 Staggered tall columns side-by-side
    final itemsCount = math.min(screenshots.length, 3);
    final offsets = [0.0, 50.0, 25.0];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(itemsCount, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: offsets[index % offsets.length],
              left: index == 0 ? 0 : 8,
              right: index == itemsCount - 1 ? 0 : 8,
            ),
            child: _TallScreenshotFrame(
              imageAsset: screenshots[index],
              height: 480,
              index: index + 1,
            ),
          ),
        );
      }),
    );
  }
}

class _TallScreenshotFrame extends StatelessWidget {
  final String imageAsset;
  final double? width;
  final double height;
  final int index;

  const _TallScreenshotFrame({
    required this.imageAsset,
    this.width,
    required this.height,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.hairline, width: 1.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Real App Screenshot Image
          ClipRect(
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.surfaceElevated,
                child: Center(
                  child: Text(
                    'SCREENSHOT\n$index',
                    textAlign: TextAlign.center,
                    style: AppTypography.monoLabel(
                      fontSize: 10,
                      color: AppColors.textDim,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Subtle hairline inner border
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x1A000000), width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RectAppButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _RectAppButton({
    required this.text,
    required this.onTap,
  });

  @override
  State<_RectAppButton> createState() => _RectAppButtonState();
}

class _RectAppButtonState extends State<_RectAppButton> {
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
          duration: const Duration(milliseconds: 140),
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceElevated : AppColors.surface,
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.borderLight,
              width: 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: AppTypography.monoLabel(
              fontSize: 12.5,
              color: _isHovered ? AppColors.accent : AppColors.textPrimary,
              letterSpacing: 0.5,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
