import 'package:flutter/material.dart';
import '../../core/animations/marquee_strip.dart';
import '../../core/animations/tilt_3d_card.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Marquee Ribbon Divider
        const MarqueeStrip(items: PortfolioData.marqueeSkills),

        const SizedBox(height: 60),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 24.0 : 54.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                number: '03 / TOOLKIT',
                title: 'Engineering Stack',
                subtitle:
                    'Specialized in the modern Flutter ecosystem, robust local storage, and scalable architecture.',
                isItalic: true,
              ),
              const SizedBox(height: 48),

              // Animated Interactive Skills Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 4;
                  if (constraints.maxWidth < 600) {
                    crossAxisCount = 2;
                  } else if (constraints.maxWidth < 960) {
                    crossAxisCount = 3;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isMobile ? 1.5 : 1.7,
                    ),
                    itemCount: PortfolioData.skills.length,
                    itemBuilder: (context, index) {
                      final skill = PortfolioData.skills[index];
                      return _SkillTile(
                        name: skill['name'] as String,
                        category: skill['category'] as String,
                        level: skill['level'] as String,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillTile extends StatefulWidget {
  final String name;
  final String category;
  final String level;

  const _SkillTile({
    required this.name,
    required this.category,
    required this.level,
  });

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tilt3DCard(
      maxTiltAngle: 0.08,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF15151F) : const Color(0xFF101014),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.accent.withValues(alpha: 0.5) : AppColors.border,
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.category.toUpperCase(),
                    style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textDim),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _isHovered ? AppColors.accent : Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: AppTypography.cardTitle(fontSize: 18).copyWith(
                      color: _isHovered ? AppColors.textPrimary : const Color(0xFFE2E0D8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.level,
                    style: AppTypography.monoLabel(
                      fontSize: 11,
                      color: _isHovered ? AppColors.accent : AppColors.textMuted,
                    ),
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
