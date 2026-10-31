import 'core/widgets/difference_header.dart';
import 'core/animations/scroll_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
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
  runApp(PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp>
    with WidgetsBindingObserver {
  SemanticsHandle? _webSemantics;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (kIsWeb) _webSemantics = SemanticsBinding.instance.ensureSemantics();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _webSemantics?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudhanshu Singh — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: AppColors.isLight ? Brightness.light : Brightness.dark,
        colorSchemeSeed: AppColors.accent,
        focusColor: AppColors.accentSubtle,
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      builder: (context, child) => TickerMode(
        enabled: !MediaQuery.disableAnimationsOf(context),
        child: child!,
      ),
      home: PortfolioHomePage(),
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
    final sections = {
      'hero': _heroKey,
      'apps': _appsKey,
      'projects': _projectsKey,
      'about': _aboutKey,
      'experience': _experienceKey,
      'contact': _contactKey,
    };
    String active = 'hero';
    for (final entry in sections.entries) {
      final box = entry.value.currentContext?.findRenderObject();
      if (box is RenderBox && box.localToGlobal(Offset.zero).dy <= 160)
        active = entry.key;
    }
    if (_activeSection != active) setState(() => _activeSection = active);
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
      final box = targetKey.currentContext!.findRenderObject() as RenderBox;
      final headerHeight = MediaQuery.paddingOf(context).top + 80;
      final target =
          (_scrollController.offset +
                  box.localToGlobal(Offset.zero).dy -
                  headerHeight)
              .clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.animateTo(
        target,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : Duration(milliseconds: 800),
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
                  painter: BackgroundGridPainter(mousePosition: _mousePosition),
                ),
              ),

            // Scrollable Content
            Positioned.fill(
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: isMobile
                            ? MediaQuery.of(context).padding.top + 72
                            : 72,
                      ),

                      // Hero Section / Index
                      Container(
                        key: _heroKey,
                        child: HeroSection(
                          mousePosition: _mousePosition,
                          onViewProjectsTap: () => _scrollToSection('apps'),
                          onResumeTap: () => ResumeModal.show(context),
                          onGithubTap: () =>
                              _launchUrl(PortfolioData.githubUrl),
                        ),
                      ),

                      // Subtle Editorial Marquee Strip
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: MarqueeStrip(items: PortfolioData.marqueeSkills),
                      ),

                      // 01. Apps (Vapi Startup Community, Bhajan & Kirtan)
                      Container(
                        key: _appsKey,
                        child: ScrollReveal(child: FeaturedProjectsSection()),
                      ),

                      // 02. Selected Projects (Animal Pop Kids, CRM365, Saifee Milk)
                      Container(
                        key: _projectsKey,
                        child: ScrollReveal(child: PrivateProjectsSection()),
                      ),

                      // 03. About Section
                      Container(
                        key: _aboutKey,
                        child: ScrollReveal(child: AboutSection()),
                      ),

                      // 04. Experience Section
                      Container(
                        key: _experienceKey,
                        child: ScrollReveal(child: ExperienceSection()),
                      ),

                      // 05. GitHub Section (Terminal CLI view)
                      ScrollReveal(child: GitHubSection()),

                      // 06. Contact Section
                      Container(
                        key: _contactKey,
                        child: ScrollReveal(child: ContactSection()),
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
                    decoration: BoxDecoration(color: AppColors.accent),
                  ),
                ),
              ),
            ),

            // Top Fixed Navbar
            Positioned(
              top: 2.0,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(bottom: BorderSide(color: AppColors.hairline)),
                ),
                child: DifferenceHeader(
                  child: isMobile
                      ? MobileNavbar(
                          isScrolled: _isScrolled,
                          onOpenMenu: () =>
                              setState(() => _isMobileMenuOpen = true),
                          onResumeTap: () => ResumeModal.show(context),
                        )
                      : DesktopNavbar(
                          isScrolled: _isScrolled,
                          activeSection: _activeSection,
                          onNavTap: _scrollToSection,
                          onResumeTap: () => ResumeModal.show(context),
                        ),
                ),
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
