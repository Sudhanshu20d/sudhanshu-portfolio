import '../../core/widgets/accessible_action.dart';
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
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
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
          SectionTitle(
            number: '01',
            title: 'Apps',
            subtitle:
                'Production mobile applications live on the stores, engineered with Flutter and clean architecture.',
          ),

          SizedBox(height: isMobile ? 36 : 64),

          // Apps Editorial Showcases
          Column(
            children: PortfolioData.publishedProjects.asMap().entries.map((
              entry,
            ) {
              final project = entry.value;

              return Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 48.0 : 96.0),
                child: _EditorialAppBlock(
                  project: project,
                  index: entry.key + 1,
                  isMobile: isMobile,
                  onPlayStoreTap: project.playStoreUrl != null
                      ? () => _launchUrl(project.playStoreUrl!)
                      : null,
                  onAppStoreTap: project.appStoreUrl != null
                      ? () => _launchUrl(project.appStoreUrl!)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _EditorialAppBlock extends StatefulWidget {
  final ProjectModel project;
  final int index;
  final bool isMobile;
  final VoidCallback? onPlayStoreTap;
  final VoidCallback? onAppStoreTap;

  const _EditorialAppBlock({
    required this.project,
    required this.index,
    required this.isMobile,
    this.onPlayStoreTap,
    this.onAppStoreTap,
  });

  @override
  State<_EditorialAppBlock> createState() => _EditorialAppBlockState();
}

class _EditorialAppBlockState extends State<_EditorialAppBlock> {
  bool _hovered = false;
  bool _showIos = true;
  final ScrollController _galleryController = ScrollController(
    keepScrollOffset: false,
  );

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  void _selectPlatform(bool ios) {
    if (_galleryController.hasClients) _galleryController.jumpTo(0);
    setState(() => _showIos = ios);
  }

  void _scrollGallery(double direction) {
    if (!_galleryController.hasClients) return;
    final position = _galleryController.position;
    _galleryController.animateTo(
      (position.pixels + direction * position.viewportDimension * 0.85).clamp(
        0.0,
        position.maxScrollExtent,
      ),
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  ProjectModel get project => widget.project;
  bool get isMobile => widget.isMobile;
  VoidCallback? get onPlayStoreTap => widget.onPlayStoreTap;
  VoidCallback? get onAppStoreTap => widget.onAppStoreTap;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hasDualStore =
        project.playStoreUrl != null && project.appStoreUrl != null;

    final infoWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${widget.index.toString().padLeft(2, '0')} / —',
          style: AppTypography.monoLabel(),
        ),
        SizedBox(height: 20),
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
              semanticLabel: '${project.title} app icon',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
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

        SizedBox(height: 20),

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

        SizedBox(height: 14),

        // Giant Bold Sans Title
        Text(
          project.title,
          style: AppTypography.displayHeading(
            fontSize: isMobile ? (screenWidth < 360 ? 34 : 42) : 64,
            color: _hovered ? AppColors.accent : AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.2,
            height: 1.02,
          ),
        ),

        SizedBox(height: 16),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies
              .map(
                (tag) => Text(
                  tag.toUpperCase(),
                  style: AppTypography.monoLabel(fontSize: 10),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 16),
        // Short Editorial Description
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480),
          child: Text(
            project.description,
            style: AppTypography.bodyLarge(
              color: AppColors.textMuted,
              height: 1.55,
            ),
          ),
        ),

        SizedBox(height: 28),

        // Rectangular Minimal Action Buttons: [ Google Play ↗ ]  [ App Store ↗ ]
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            if (onPlayStoreTap != null)
              _RectAppButton(text: 'Google Play ↗', onTap: onPlayStoreTap!),
            if (onAppStoreTap != null)
              _RectAppButton(text: 'App Store ↗', onTap: onAppStoreTap!),
          ],
        ),
      ],
    );

    // Screenshots Widget
    final screenshotsWidget = _buildScreenshotsLayout(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [infoWidget, SizedBox(height: 32), screenshotsWidget],
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Container(
        padding: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.hairline)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: App details and controls
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: infoWidget,
              ),
            ),

            SizedBox(width: 48),

            // Right Column: Staggered tall vertical phone screenshot mockups
            Expanded(flex: 7, child: screenshotsWidget),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenshotsLayout(BuildContext context) {
    final hasIos = project.iosScreenshotAssets.isNotEmpty;
    final ios = hasIos && _showIos;
    final screenshots = ios
        ? project.iosScreenshotAssets
        : project.screenshotAssets;
    if (screenshots.isEmpty) return const SizedBox.shrink();
    final platform = ios ? 'iPhone / App Store' : 'Android / Google Play';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasIos)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Semantics(
                selected: ios,
                child: TextButton(
                  onPressed: () => _selectPlatform(true),
                  child: Text(
                    'iPhone / App Store',
                    style: AppTypography.monoLabel(
                      fontSize: 10,
                      color: ios ? AppColors.accent : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
              Semantics(
                selected: !ios,
                child: TextButton(
                  onPressed: () => _selectPlatform(false),
                  child: Text(
                    'Android / Google Play',
                    style: AppTypography.monoLabel(
                      fontSize: 10,
                      color: !ios ? AppColors.accent : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          Text(
            platform.toUpperCase(),
            style: AppTypography.monoLabel(fontSize: 10),
          ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = isMobile
                ? (constraints.maxWidth * 0.7).clamp(160.0, 220.0)
                : (constraints.maxWidth - 28) / 3;
            final galleryHeight = isMobile ? 420.0 : 480.0;
            return SizedBox(
              height: galleryHeight + 16,
              child: Scrollbar(
                controller: _galleryController,
                thumbVisibility: !isMobile,
                child: ListView.separated(
                  key: ValueKey('${project.id}-$ios'),
                  controller: _galleryController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: screenshots.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) => _TallScreenshotFrame(
                    imageAsset: screenshots[index],
                    width: cardWidth,
                    height: galleryHeight,
                    index: index + 1,
                    semanticLabel:
                        '${project.title}, $platform screenshot ${index + 1}',
                  ),
                ),
              ),
            );
          },
        ),
        Row(
          children: [
            const Spacer(),
            IconButton(
              tooltip: 'Previous ${project.title} screenshots',
              onPressed: () => _scrollGallery(-1),
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              tooltip: 'Next ${project.title} screenshots',
              onPressed: () => _scrollGallery(1),
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }
}

class _TallScreenshotFrame extends StatelessWidget {
  final String imageAsset;
  final double? width;
  final double height;
  final int index;
  final String semanticLabel;

  const _TallScreenshotFrame({
    required this.imageAsset,
    required this.semanticLabel,
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
              semanticLabel: semanticLabel,
              fit: BoxFit.contain,
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
                  border: Border.all(color: Color(0x1A000000), width: 1),
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

  const _RectAppButton({required this.text, required this.onTap});

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
      child: AccessibleAction(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration:
              WidgetsBinding
                  .instance
                  .platformDispatcher
                  .accessibilityFeatures
                  .disableAnimations
              ? Duration.zero
              : Duration(milliseconds: 140),
          constraints: BoxConstraints(minHeight: 44),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
