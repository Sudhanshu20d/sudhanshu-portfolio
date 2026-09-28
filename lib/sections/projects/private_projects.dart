import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_title.dart';

class PrivateProjectsSection extends StatelessWidget {
  const PrivateProjectsSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showProjectModal(BuildContext context, Map<String, String> project) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.accent, width: 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${project['id']} / SELECTED PROJECT',
                    style: AppTypography.monoNumber(fontSize: 12, color: AppColors.accent),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                project['title']!,
                style: AppTypography.displayHeading(fontSize: 36),
              ),
              const SizedBox(height: 12),
              Text(
                project['description']!,
                style: AppTypography.bodyLead(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.hairline),
                    ),
                    child: Text(
                      'TECH: ${project['tag']}',
                      style: AppTypography.monoLabel(fontSize: 11, color: AppColors.accent),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => _launchUrl(project['url']!),
                    child: Text(
                      'View on GitHub ↗',
                      style: AppTypography.monoLabel(fontSize: 12, color: AppColors.textPrimary)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
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
          // Section Heading: 02  Selected projects
          const SectionTitle(
            number: '02',
            title: 'Selected projects',
            subtitle:
                'Curated mobile client builds, enterprise management solutions, and interactive applications.',
          ),

          SizedBox(height: isMobile ? 32 : 48),

          // Hairline rule above list
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.hairline,
          ),

          // Editorial List Rows matching Screenshot 1
          ...PortfolioData.selectedProjects.map((project) {
            return _EditorialListRow(
              index: project['id']!,
              title: project['title']!,
              description: project['description']!,
              tag: '${project['tag']} ↗',
              isMobile: isMobile,
              onTap: () => _showProjectModal(context, project),
            );
          }),
        ],
      ),
    );
  }
}

class _EditorialListRow extends StatefulWidget {
  final String index;
  final String title;
  final String description;
  final String tag;
  final bool isMobile;
  final VoidCallback onTap;

  const _EditorialListRow({
    required this.index,
    required this.title,
    required this.description,
    required this.tag,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<_EditorialListRow> createState() => _EditorialListRowState();
}

class _EditorialListRowState extends State<_EditorialListRow> {
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
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceElevated.withValues(alpha: 0.5) : Colors.transparent,
            border: const Border(
              bottom: BorderSide(color: AppColors.hairline, width: 1.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: widget.isMobile ? 24.0 : 36.0,
            horizontal: widget.isMobile ? 8.0 : 16.0,
          ),
          child: widget.isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.index,
                          style: AppTypography.monoNumber(
                            fontSize: 12,
                            color: _isHovered ? AppColors.accent : AppColors.textDim,
                          ),
                        ),
                        Text(
                          widget.tag,
                          style: AppTypography.monoLabel(
                            fontSize: 11,
                            color: _isHovered ? AppColors.accent : AppColors.textMuted,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: AppTypography.displayHeading(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.8,
                        color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: AppTypography.bodyMedium(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Index Number
                    SizedBox(
                      width: 48,
                      child: Text(
                        widget.index,
                        style: AppTypography.monoNumber(
                          fontSize: 14,
                          color: _isHovered ? AppColors.accent : AppColors.textDim,
                        ),
                      ),
                    ),

                    // Title
                    Expanded(
                      flex: 4,
                      child: Text(
                        widget.title,
                        style: AppTypography.displayHeading(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.0,
                          color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),

                    // Description
                    Expanded(
                      flex: 6,
                      child: Text(
                        widget.description,
                        style: AppTypography.bodyLarge(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),

                    // Tag FLUTTER ↗
                    Text(
                      widget.tag,
                      style: AppTypography.monoLabel(
                        fontSize: 12,
                        color: _isHovered ? AppColors.accent : AppColors.textMuted,
                        letterSpacing: 1.2,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
