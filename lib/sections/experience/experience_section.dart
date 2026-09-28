import 'package:flutter/material.dart';
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
    final isMobile = screenWidth < 880;
    final isTiny = screenWidth < 360;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isTiny ? 16.0 : 20.0) : 48.0,
        vertical: isMobile ? 36.0 : 64.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            number: '04',
            title: 'Experience',
            subtitle:
                'Hands-on engineering across client production deployments, internal enterprise tools, and Google Play Store consumer releases.',
          ),
          SizedBox(height: isMobile ? 36 : 48),

          // Editorial Career Ledger
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.experiences.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final exp = PortfolioData.experiences[index];
              return _EditorialExperienceRow(
                experience: exp,
                isMobile: isMobile,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EditorialExperienceRow extends StatefulWidget {
  final ExperienceModel experience;
  final bool isMobile;

  const _EditorialExperienceRow({
    required this.experience,
    required this.isMobile,
  });

  @override
  State<_EditorialExperienceRow> createState() => _EditorialExperienceRowState();
}

class _EditorialExperienceRowState extends State<_EditorialExperienceRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.experience.status == 'CURRENT';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 16.0 : 28.0,
          vertical: widget.isMobile ? 20.0 : 30.0,
        ),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border(
            top: BorderSide(
              color: _isHovered ? AppColors.accent : AppColors.hairline,
              width: _isHovered ? 1.5 : 1.0,
            ),
          ),
        ),
        child: widget.isMobile
            ? _buildMobileLayout(isCurrent)
            : _buildDesktopLayout(isCurrent),
      ),
    );
  }

  Widget _buildDesktopLayout(bool isCurrent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Index + Status Badge
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.experience.index,
                style: AppTypography.editorialIndex(fontSize: 40).copyWith(
                  color: isCurrent ? AppColors.accent : AppColors.textDim,
                ),
              ),
              const SizedBox(height: 6),
              if (isCurrent)
                const LuxuryBadge(
                  label: 'CURRENT ROLE',
                  dotColor: AppColors.liveGreen,
                )
              else
                Text(
                  'PREVIOUS',
                  style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textDim),
                ),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // Column 2: Company + Role + Location
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.experience.company,
                style: AppTypography.cardTitle(fontSize: 24).copyWith(
                  color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.experience.role.toUpperCase(),
                style: AppTypography.monoLabel(
                  fontSize: 11.5,
                  color: AppColors.textPrimary,
                ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.0),
              ),
              const SizedBox(height: 4),
              Text(
                widget.experience.location,
                style: AppTypography.monoLabel(fontSize: 10.5, color: AppColors.textMuted),
              ),
            ],
          ),
        ),

        const SizedBox(width: 28),

        // Column 3: Factual Responsibilities & Technologies
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.experience.summary,
                style: AppTypography.bodyMedium(height: 1.6),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.experience.technologies.map((tech) {
                  return LuxuryBadge(
                    label: tech,
                    backgroundColor: const Color(0x0AFFFFFF),
                    borderColor: AppColors.hairline,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isCurrent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.experience.index,
              style: AppTypography.editorialIndex(fontSize: 32).copyWith(
                color: isCurrent ? AppColors.accent : AppColors.textDim,
              ),
            ),
            if (isCurrent)
              const LuxuryBadge(
                label: 'CURRENT ROLE',
                dotColor: AppColors.liveGreen,
              )
            else
              Text(
                'PREVIOUS',
                style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textDim),
              ),
          ],
        ),

        const SizedBox(height: 10),

        Text(
          widget.experience.company,
          style: AppTypography.cardTitle(fontSize: 20).copyWith(
            color: _isHovered ? AppColors.accent : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.experience.role.toUpperCase(),
          style: AppTypography.monoLabel(
            fontSize: 10.5,
            color: AppColors.accent,
          ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.8),
        ),
        const SizedBox(height: 3),
        Text(
          widget.experience.location,
          style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textMuted),
        ),

        const SizedBox(height: 12),

        Text(
          widget.experience.summary,
          style: AppTypography.bodyMedium(height: 1.55),
        ),

        const SizedBox(height: 14),

        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: widget.experience.technologies.map((tech) {
            return LuxuryBadge(
              label: tech,
              backgroundColor: const Color(0x0AFFFFFF),
              borderColor: AppColors.hairline,
            );
          }).toList(),
        ),
      ],
    );
  }
}
