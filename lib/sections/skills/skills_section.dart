import 'package:flutter/material.dart';
import '../../core/animations/marquee_strip.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 860;
    final isTiny = screenWidth < 360;

    final Map<String, List<Map<String, String>>> skillCategories = {
      '01 / RUNTIMES & SDK': [
        {'name': 'Flutter', 'role': 'Cross-Platform Framework', 'level': 'Core'},
        {'name': 'Dart', 'role': 'Object-Oriented Language', 'level': 'Core'},
        {'name': 'Android Native', 'role': 'Platform SDK & Manifests', 'level': 'Platform'},
      ],
      '02 / STATE & ARCHITECTURE': [
        {'name': 'BLoC Pattern', 'role': 'Predictable Reactive State', 'level': 'Production'},
        {'name': 'Provider', 'role': 'Dependency Injection & State', 'level': 'Production'},
        {'name': 'Clean Architecture', 'role': 'Modular Repository Pattern', 'level': 'Discipline'},
      ],
      '03 / DATA & NETWORKING': [
        {'name': 'REST APIs', 'role': 'HTTP Client & JSON Parsing', 'level': 'Integration'},
        {'name': 'SQLite', 'role': 'Relational Local DB', 'level': 'Offline First'},
        {'name': 'Hive', 'role': 'Fast Key-Value NoSQL Store', 'level': 'Cache'},
        {'name': 'Firebase', 'role': 'Auth, Firestore & Push', 'level': 'Cloud'},
      ],
      '04 / STUDIO TOOLKIT': [
        {'name': 'Git & GitHub', 'role': 'Version Control & Releases', 'level': 'Standard'},
        {'name': 'Android Studio', 'role': 'Profiling & Emulation', 'level': 'IDE'},
        {'name': 'VS Code', 'role': 'Dart Tooling & Linting', 'level': 'Daily Driver'},
        {'name': 'Figma', 'role': 'Design Specs & Vector Export', 'level': 'UI/UX Specs'},
      ],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Textural Editorial Ticker
        const MarqueeStrip(items: PortfolioData.marqueeSkills),

        const SizedBox(height: 36),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? (isTiny ? 16.0 : 20.0) : 48.0,
            vertical: isMobile ? 24.0 : 36.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                number: '03 / TOOLKIT & SPECS',
                title: 'Technical Capabilities',
                subtitle:
                    'Engineered around modern cross-platform development, robust local storage, and scalable mobile architecture.',
                isItalic: true,
              ),
              const SizedBox(height: 40),

              // Architectural Matrix
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: skillCategories.entries
                      .map((entry) => _buildCategoryGroup(entry.key, entry.value, isMobile))
                      .toList(),
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _buildCategoryGroup(
                            skillCategories.keys.elementAt(0),
                            skillCategories.values.elementAt(0),
                            isMobile,
                          ),
                          const SizedBox(height: 28),
                          _buildCategoryGroup(
                            skillCategories.keys.elementAt(2),
                            skillCategories.values.elementAt(2),
                            isMobile,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        children: [
                          _buildCategoryGroup(
                            skillCategories.keys.elementAt(1),
                            skillCategories.values.elementAt(1),
                            isMobile,
                          ),
                          const SizedBox(height: 28),
                          _buildCategoryGroup(
                            skillCategories.keys.elementAt(3),
                            skillCategories.values.elementAt(3),
                            isMobile,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGroup(
    String categoryTitle,
    List<Map<String, String>> items,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header (Safe against overflow)
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.hairline)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  categoryTitle,
                  style: AppTypography.monoNumber(
                    fontSize: 10.5,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${items.length} MODULES',
                style: AppTypography.monoLabel(fontSize: 9.5, color: AppColors.textDim),
              ),
            ],
          ),
        ),

        // Items List
        ...items.map((item) => _SkillLedgerRow(item: item)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _SkillLedgerRow extends StatefulWidget {
  final Map<String, String> item;

  const _SkillLedgerRow({required this.item});

  @override
  State<_SkillLedgerRow> createState() => _SkillLedgerRowState();
}

class _SkillLedgerRowState extends State<_SkillLedgerRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border(
            bottom: BorderSide(
              color: _isHovered ? AppColors.accent.withValues(alpha: 0.4) : AppColors.hairline,
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['name']!,
                    style: AppTypography.cardTitle(fontSize: 17).copyWith(
                      color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.item['role']!,
                    style: AppTypography.bodySmall(color: AppColors.textMuted),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0x1FA78BFA) : const Color(0x0CFFFFFF),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: _isHovered ? AppColors.accent : AppColors.hairline,
                  width: 0.8,
                ),
              ),
              child: Text(
                widget.item['level']!.toUpperCase(),
                style: AppTypography.monoLabel(
                  fontSize: 9.5,
                  color: _isHovered ? AppColors.accent : AppColors.textDim,
                ).copyWith(letterSpacing: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
