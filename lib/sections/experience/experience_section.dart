import 'package:flutter/material.dart';
import '../../core/animations/tilt_3d_card.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/luxury_badge.dart';
import '../../core/widgets/section_title.dart';
import '../../models/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 54.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            number: '02 / TIMELINE',
            title: 'Professional Track',
            subtitle:
                'Engineering real mobile applications across collaborative software environments.',
            isItalic: true,
          ),
          const SizedBox(height: 52),

          // Timeline Cards list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.experiences.length,
            separatorBuilder: (context, index) => const SizedBox(height: 28),
            itemBuilder: (context, index) {
              final exp = PortfolioData.experiences[index];
              return _TimelineCard(experience: exp, isMobile: isMobile);
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatefulWidget {
  final ExperienceModel experience;
  final bool isMobile;

  const _TimelineCard({
    required this.experience,
    required this.isMobile,
  });

  @override
  State<_TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<_TimelineCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.experience.status == 'CURRENT';

    return Tilt3DCard(
      maxTiltAngle: 0.04,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(widget.isMobile ? 24.0 : 36.0),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF14141B) : const Color(0xFF101015),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accent.withValues(alpha: 0.4)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.08),
                  blurRadius: 32,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: 01/02 Number + Status Badge + Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.experience.index,
                    style: AppTypography.monoNumber(
                      fontSize: widget.isMobile ? 28 : 38,
                      color: isCurrent ? AppColors.accent : AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.experience.company,
                              style: AppTypography.cardTitle(
                                fontSize: widget.isMobile ? 22 : 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (isCurrent)
                              const LuxuryBadge(
                                label: 'CURRENT',
                                dotColor: AppColors.liveGreen,
                                backgroundColor: Color(0x1510B981),
                                borderColor: Color(0x4010B981),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.experience.role,
                          style: AppTypography.monoLabel(
                            fontSize: 13,
                            color: AppColors.accent,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isMobile)
                    Text(
                      widget.experience.location,
                      style: AppTypography.monoLabel(fontSize: 12, color: AppColors.textMuted),
                    ),
                ],
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                widget.experience.summary,
                style: AppTypography.bodyMedium(height: 1.6),
              ),

              const SizedBox(height: 20),

              // Technologies used
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.experience.technologies.map((tech) {
                  return LuxuryBadge(
                    label: tech,
                    backgroundColor: const Color(0x0EFFFFFF),
                    borderColor: AppColors.border,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
