import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'core/animations/cursor_spotlight.dart';
import 'core/animations/marquee_strip.dart';
import 'core/constants/portfolio_data.dart';
import 'core/theme/app_colors.dart';
import 'core/widgets/resume_modal.dart';
import 'sections/about/about_section.dart';
import 'sections/contact/contact_section.dart';
import 'sections/experience/experience_section.dart';
import 'sections/footer/footer_section.dart';
import 'sections/github/github_section.dart';
import 'sections/hero/hero_section.dart';
import 'sections/navbar/desktop_navbar.dart';
import 'sections/navbar/mobile_drawer.dart';
import 'sections/projects/featured_projects.dart';
import 'sections/projects/private_projects.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudhanshu Singh — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  Offset _mousePosition = Offset.zero;
  bool _isScrolled = false;
  double _scrollProgress = 0.0;
  String _activeSection = 'hero';
  bool _isMobileMenuOpen = false;

  // Global Keys for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _appsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final progress = maxScroll > 0 ? (offset / maxScroll).clamp(0.0, 1.0) : 0.0;

    final scrolled = offset > 40;
    if (scrolled != _isScrolled || progress != _scrollProgress) {
      setState(() {
        _isScrolled = scrolled;
        _scrollProgress = progress;
      });
    }

    _detectActiveSection();
  }

  void _detectActiveSection() {
    final offset = _scrollController.offset;
    if (offset < 500) {
      if (_activeSection != 'hero') setState(() => _activeSection = 'hero');
    } else if (offset < 1500) {
      if (_activeSection != 'apps') setState(() => _activeSection = 'apps');
    } else if (offset < 2400) {
      if (_activeSection != 'projects') setState(() => _activeSection = 'projects');
    } else if (offset < 3200) {
      if (_activeSection != 'about') setState(() => _activeSection = 'about');
    } else if (offset < 4000) {
      if (_activeSection != 'experience') setState(() => _activeSection = 'experience');
    } else {
      if (_activeSection != 'contact') setState(() => _activeSection = 'contact');
    }
  }

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    switch (section) {
      case 'hero':
        targetKey = _heroKey;
        break;
      case 'apps':
        targetKey = _appsKey;
        break;
      case 'projects':
        targetKey = _projectsKey;
        break;
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'experience':
        targetKey = _experienceKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 960;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MouseRegion(
        onHover: (e) {
          setState(() {
            _mousePosition = e.position;
          });
        },
        child: Stack(
          children: [
            // Moving editorial grid and ambient spotlight background
            if (!isMobile)
              Positioned.fill(
                child: CustomPaint(
                  painter: BackgroundGridPainter(
                    mousePosition: _mousePosition,
                  ),
                ),
              ),

            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(height: isMobile ? MediaQuery.of(context).padding.top + 64 : 72),

                    // Hero Section / Index
                    Container(
                      key: _heroKey,
                      child: HeroSection(
                        mousePosition: _mousePosition,
                        onViewProjectsTap: () => _scrollToSection('apps'),
                        onResumeTap: () => ResumeModal.show(context),
                        onGithubTap: () => _launchUrl(PortfolioData.githubUrl),
                      ),
                    ),

                    // Subtle Editorial Marquee Strip
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: MarqueeStrip(items: PortfolioData.marqueeSkills),
                    ),

                    // 01. Apps (Vapi Startup Community, Bhajan & Kirtan)
                    Container(
                      key: _appsKey,
                      child: const FeaturedProjectsSection(),
                    ),

                    // 02. Selected Projects (Animal Pop Kids, CRM365, Saifee Milk)
                    Container(
                      key: _projectsKey,
                      child: const PrivateProjectsSection(),
                    ),

                    // 03. About Section
                    Container(
                      key: _aboutKey,
                      child: const AboutSection(),
                    ),

                    // 04. Experience Section
                    Container(
                      key: _experienceKey,
                      child: const ExperienceSection(),
                    ),

                    // 05. GitHub Section (Terminal CLI view)
                    const GitHubSection(),

                    // 06. Contact Section
                    Container(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),

                    // Footer
                    FooterSection(
                      onScrollToTop: _scrollToTop,
                      onNavTap: _scrollToSection,
                    ),
                  ],
                ),
              ),
            ),

            // Top Reading Progress Line (Minimal indicator)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2.0,
                color: Colors.transparent,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _scrollProgress,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
            ),

            // Top Fixed Navbar
            Positioned(
              top: 2.0,
              left: 0,
              right: 0,
              child: isMobile
                  ? MobileNavbar(
                      isScrolled: _isScrolled,
                      onOpenMenu: () => setState(() => _isMobileMenuOpen = true),
                      onResumeTap: () => ResumeModal.show(context),
                    )
                  : DesktopNavbar(
                      isScrolled: _isScrolled,
                      activeSection: _activeSection,
                      onNavTap: _scrollToSection,
                      onResumeTap: () => ResumeModal.show(context),
                    ),
            ),

            // Fullscreen Mobile Drawer
            if (isMobile && _isMobileMenuOpen)
              Positioned.fill(
                child: MobileDrawer(
                  onNavTap: _scrollToSection,
                  onClose: () => setState(() => _isMobileMenuOpen = false),
                  onResumeTap: () => ResumeModal.show(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
