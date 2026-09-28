import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/portfolio_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_title.dart';
import '../../models/github_repo_model.dart';

class GitHubSection extends StatelessWidget {
  const GitHubSection({super.key});

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

  static String getMobileDescription(String repoName, String originalDesc) {
    switch (repoName) {
      case 'cinebook':
        return 'Cinema ticket booking application';
      case 'doctor_appointment':
        return 'Doctor appointment booking app';
      case 'HabitX':
        return 'Habit and daily routine tracker';
      case 'flutter-auth-app':
        return 'Flutter authentication with REST APIs';
      case 'Flutter---Offline-Database--Sqlite':
        return 'Local storage experiments with SQLite & Hive';
      default:
        return originalDesc.length > 50 ? '${originalDesc.substring(0, 48)}...' : originalDesc;
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
        horizontal: isMobile ? (isTiny ? 14.0 : 18.0) : 48.0,
        vertical: isMobile ? 32.0 : 64.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading: 05 — GITHUB
          const SectionTitle(
            number: '05',
            title: 'GitHub',
            subtitle: 'Code, experiments and projects.',
          ),

          SizedBox(height: isMobile ? 24 : 44),

          // Responsive presentation: Mobile is concise and editorial; Desktop is full CLI session
          if (isMobile)
            _buildMobileLayout(context)
          else
            _buildDesktopTerminal(context),
        ],
      ),
    );
  }

  // ==========================================
  // MOBILE: COMPACT & READABLE EDITORIAL VIEW
  // ==========================================
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Compact Profile Terminal Block
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0C0E),
            border: Border.all(color: AppColors.hairline, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Terminal Title Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(bottom: BorderSide(color: AppColors.hairline)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDot(),
                        const SizedBox(width: 5),
                        _buildDot(),
                        const SizedBox(width: 5),
                        _buildDot(),
                        const SizedBox(width: 10),
                        Text(
                          'gh-cli',
                          style: AppTypography.monoLabel(fontSize: 10, color: AppColors.textDim),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${PortfolioData.githubUsername}@vapi:~',
                        style: AppTypography.monoNumber(fontSize: 10, color: AppColors.accent),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Compact $ gh user view
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCommandLine('gh user view'),
                    const SizedBox(height: 10),
                    _buildMobileUserSpecs(),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // 2. Repositories Section Heading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'PUBLIC REPOSITORIES',
                style: AppTypography.monoNumber(fontSize: 11, color: AppColors.accent),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${PortfolioData.githubRepos.length} REPOS',
              style: AppTypography.monoLabel(fontSize: 9.5, color: AppColors.textDim),
            ),
          ],
        ),

        const SizedBox(height: 12),
        Container(width: double.infinity, height: 1, color: AppColors.hairline),

        // 3. Clean Editorial Repository Rows (1-2 lines per repo)
        ...PortfolioData.githubRepos.map((repo) {
          return _MobileRepoItem(
            name: repo.name,
            tag: repo.badge,
            description: getMobileDescription(repo.name, repo.description),
            onTap: () => _launchUrl(repo.url),
          );
        }),

        const SizedBox(height: 28),

        // 4. Open GitHub Profile Button
        SizedBox(
          width: double.infinity,
          child: _RectGithubButton(
            onTap: () => _launchUrl(PortfolioData.githubUrl),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileUserSpecs() {
    final specs = [
      {'key': 'login', 'val': PortfolioData.githubUsername},
      {'key': 'role', 'val': 'Flutter Developer'},
      {'key': 'company', 'val': PortfolioData.company},
      {'key': 'location', 'val': PortfolioData.location},
    ];

    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.hairline, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: specs.map((s) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                SizedBox(
                  width: 76,
                  child: Text(
                    s['key']!,
                    style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textDim),
                  ),
                ),
                Expanded(
                  child: Text(
                    s['val']!,
                    style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==========================================
  // DESKTOP: FULL TERMINAL CLI VIEW
  // ==========================================
  Widget _buildDesktopTerminal(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C0E),
        border: Border.all(color: AppColors.hairline, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal Window Title Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(bottom: BorderSide(color: AppColors.hairline)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDot(),
                    const SizedBox(width: 6),
                    _buildDot(),
                    const SizedBox(width: 6),
                    _buildDot(),
                    const SizedBox(width: 14),
                    Text(
                      'gh-cli — session',
                      style: AppTypography.monoLabel(fontSize: 10.5, color: AppColors.textDim),
                    ),
                  ],
                ),
                Text(
                  '${PortfolioData.githubUsername}@vapi:~',
                  style: AppTypography.monoNumber(fontSize: 10.5, color: AppColors.accent),
                ),
              ],
            ),
          ),

          // Terminal Command Output
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // $ gh user view
                _buildCommandLine('gh user view'),
                const SizedBox(height: 12),
                _buildDesktopUserTable(),

                const SizedBox(height: 28),

                // $ gh repo list
                _buildCommandLine('gh repo list --public --limit 5'),
                const SizedBox(height: 16),
                _buildDesktopReposLedger(),

                const SizedBox(height: 28),

                // $ gh activity
                _buildCommandLine('gh activity --verified'),
                const SizedBox(height: 12),
                _buildDesktopActivityList(),

                const SizedBox(height: 32),

                // Action Link
                _RectGithubButton(
                  onTap: () => _launchUrl(PortfolioData.githubUrl),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: Color(0x40FFFFFF),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCommandLine(String cmd) {
    return Row(
      children: [
        Text(
          '\$ ',
          style: AppTypography.monoNumber(fontSize: 13, color: AppColors.accent),
        ),
        Flexible(
          child: Text(
            cmd,
            style: AppTypography.monoLabel(fontSize: 12.5, color: AppColors.textPrimary)
                .copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopUserTable() {
    final fields = [
      {'key': 'login', 'val': PortfolioData.githubUsername},
      {'key': 'name', 'val': PortfolioData.name},
      {'key': 'role', 'val': 'Flutter Developer (Android & iOS)'},
      {'key': 'company', 'val': PortfolioData.company},
      {'key': 'location', 'val': PortfolioData.location},
      {'key': 'url', 'val': PortfolioData.githubUrl},
    ];

    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.hairline, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map((f) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    f['key']!,
                    style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textDim),
                  ),
                ),
                Expanded(
                  child: Text(
                    f['val']!,
                    style: AppTypography.monoLabel(
                      fontSize: 11,
                      color: f['key'] == 'url' ? AppColors.accent : AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesktopReposLedger() {
    return Column(
      children: PortfolioData.githubRepos.map((repo) {
        return _DesktopRepoRow(repo: repo);
      }).toList(),
    );
  }

  Widget _buildDesktopActivityList() {
    final items = [
      'Published Vapi Startup Community on Google Play and Apple App Store',
      'Engineered Bhajan & Kirtan music streaming player architecture',
      'Implemented clean architecture with deterministic BLoC & Provider states',
      'Engineered offline-first local persistence layers via Hive and SQLite',
    ];

    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.hairline, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✓  ',
                  style: AppTypography.monoNumber(fontSize: 11, color: AppColors.liveGreen),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Mobile Clean Editorial Row
class _MobileRepoItem extends StatefulWidget {
  final String name;
  final String tag;
  final String description;
  final VoidCallback onTap;

  const _MobileRepoItem({
    required this.name,
    required this.tag,
    required this.description,
    required this.onTap,
  });

  @override
  State<_MobileRepoItem> createState() => _MobileRepoItemState();
}

class _MobileRepoItemState extends State<_MobileRepoItem> {
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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.hairline, width: 0.8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: AppTypography.displayHeading(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                        color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.tag} ↗',
                    style: AppTypography.monoLabel(
                      fontSize: 10,
                      color: _isHovered ? AppColors.accent : AppColors.textDim,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.description,
                style: AppTypography.bodySmall(color: AppColors.textMuted),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Desktop CLI Repo Row
class _DesktopRepoRow extends StatefulWidget {
  final GitHubRepoModel repo;

  const _DesktopRepoRow({required this.repo});

  @override
  State<_DesktopRepoRow> createState() => _DesktopRepoRowState();
}

class _DesktopRepoRowState extends State<_DesktopRepoRow> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Error launching url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _launchUrl(widget.repo.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0x1AD2F832) : Colors.transparent,
            border: const Border(bottom: BorderSide(color: AppColors.hairline, width: 0.6)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 260,
                child: Text(
                  widget.repo.name,
                  style: AppTypography.monoLabel(
                    fontSize: 12,
                    color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                  ).copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.repo.description,
                  style: AppTypography.monoLabel(fontSize: 11, color: AppColors.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '[ ${widget.repo.badge} ↗ ]',
                style: AppTypography.monoNumber(
                  fontSize: 10.5,
                  color: _isHovered ? AppColors.accent : AppColors.textDim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RectGithubButton extends StatefulWidget {
  final VoidCallback onTap;

  const _RectGithubButton({required this.onTap});

  @override
  State<_RectGithubButton> createState() => _RectGithubButtonState();
}

class _RectGithubButtonState extends State<_RectGithubButton> {
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.github, size: 14, color: AppColors.accent),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'OPEN GITHUB PROFILE ↗',
                  style: AppTypography.monoLabel(
                    fontSize: 11.5,
                    color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                    letterSpacing: 0.5,
                  ).copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
