import '../../models/experience_model.dart';
import '../../models/github_repo_model.dart';
import '../../models/project_model.dart';

class PortfolioData {
  PortfolioData._();

  // Personal Info
  static const String name = 'Sudhanshu Singh';
  static const String monogram = 'SD';
  static const String role = 'Flutter Developer • Mobile App Developer';
  static const String headline = 'CRAFTING RESILIENT MOBILE EXPERIENCES';
  static const String location = 'Vapi, Gujarat, India';
  static const String company = 'RND Technosoft';
  static const String previousCompany = 'AGB Software';
  static const String email = 'about.sudhanshu@gmail.com';
  static const String githubUsername = 'Sudhanshu20d';

  // Social URLs
  static const String githubUrl = 'https://github.com/Sudhanshu20d';
  static const String linkedinUrl = 'https://www.linkedin.com/in/sudhanshu-singh-0a4822278/';
  static const String instagramUrl = 'https://www.instagram.com/Shudhanshu_sd/';
  static const String twitterUrl = 'https://x.com/shudhanshu_sd?s=11';

  // Images
  static const String portraitAsset = 'assets/images/portrait/sudhanshu.jpg';
  static const String githubAvatarAsset = 'assets/images/portrait/github_avatar.png';

  // Metadata pills
  static const List<String> heroPills = [
    'Flutter Developer',
    'Vapi / Gujarat / India',
    'Available for Freelance',
    '2026 Portfolio',
  ];

  // About Statement
  static const String aboutStatement =
      'I build production-ready Flutter applications focused on performance, clean architecture, scalable APIs and delightful user experience.';

  static const String aboutBio =
      'Specialized in architecting high-performance cross-platform mobile apps for Android and iOS using Flutter and Dart. With experience shipping consumer applications on the Google Play Store as well as building dedicated enterprise distribution tools at RND Technosoft and AGB Software, I turn product requirements into fluid, 60fps user experiences with clean state management and modular architecture.';

  // Experience Timeline
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      index: '01',
      company: 'RND Technosoft',
      role: 'Flutter Developer',
      location: 'Vapi, Gujarat, India',
      status: 'CURRENT',
      summary:
          'Engineering production Flutter mobile applications, integrating complex REST APIs, state management architectures, and delivering published consumer and commercial applications to the Google Play Store.',
      technologies: ['Flutter', 'Dart', 'REST APIs', 'State Management', 'Git', 'Android'],
    ),
    ExperienceModel(
      index: '02',
      company: 'AGB Software',
      role: 'Flutter App Developer',
      location: 'India',
      status: 'PREVIOUS',
      summary:
          'Developed responsive cross-platform user interfaces, local storage workflows, and mobile application modules with clean Dart codebases and team collaboration.',
      technologies: ['Flutter', 'Dart', 'Local Storage', 'Responsive UI', 'Git'],
    ),
  ];

  // Skills Board
  static const List<Map<String, dynamic>> skills = [
    {'name': 'Flutter', 'category': 'Framework', 'level': 'Core'},
    {'name': 'Dart', 'category': 'Language', 'level': 'Core'},
    {'name': 'Firebase', 'category': 'Cloud & Tools', 'level': 'Technology'},
    {'name': 'REST APIs', 'category': 'Networking', 'level': 'Integration'},
    {'name': 'Bloc', 'category': 'Architecture', 'level': 'State Management'},
    {'name': 'Provider', 'category': 'Architecture', 'level': 'State Management'},
    {'name': 'Hive', 'category': 'Storage', 'level': 'Local DB'},
    {'name': 'SQLite', 'category': 'Storage', 'level': 'Local DB'},
    {'name': 'Git', 'category': 'VCS', 'level': 'Version Control'},
    {'name': 'GitHub', 'category': 'VCS & CI', 'level': 'Collaboration'},
    {'name': 'Android Studio', 'category': 'IDE', 'level': 'Development'},
    {'name': 'VS Code', 'category': 'IDE', 'level': 'Development'},
    {'name': 'Figma', 'category': 'Design', 'level': 'UI/UX Specs'},
  ];

  static const List<String> marqueeSkills = [
    'FLUTTER',
    '•',
    'DART',
    '•',
    'REST APIS',
    '•',
    'STATE MANAGEMENT',
    '•',
    'BLOC',
    '•',
    'PROVIDER',
    '•',
    'FIREBASE',
    '•',
    'HIVE',
    '•',
    'SQLITE',
    '•',
    'CLEAN ARCHITECTURE',
    '•',
    'ANDROID',
    '•',
    'RESPONSIVE UI',
    '•',
    'GIT & GITHUB',
    '•',
  ];

  // Published Projects
  static const List<ProjectModel> publishedProjects = [
    ProjectModel(
      id: 'vapi-startup-community',
      title: 'StartupVapi Community',
      subtitle: 'Learn | Share | Grow | Build Together',
      category: 'COMMUNITY & ECOSYSTEM',
      description:
          'A vibrant entrepreneurship and innovation ecosystem mobile app built for founders, students, professionals, and dreamers to learn, grow, and build impactful businesses together.',
      keyFeatures: [
        'Entrepreneurship & founder networking hub',
        'Events, workshops, and ecosystem discovery',
        'Interactive community feeds and resources',
        'Responsive mobile experience optimized for Android',
      ],
      technologies: ['Flutter', 'Dart', 'REST APIs', 'State Management'],
      iconAsset: 'assets/images/projects/vapi_startup_icon.png',
      screenshotAssets: [
        'assets/images/projects/vapi_startup_screen1.png',
        'assets/images/projects/vapi_startup_screen2.png',
        'assets/images/projects/vapi_startup_screen3.png',
        'assets/images/projects/vapi_startup_screen4.png',
      ],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.app.mycitycommunity',
      type: ProjectType.published,
    ),
    ProjectModel(
      id: 'bhajan-kirtan',
      title: 'Bhajan & Kirtan',
      subtitle: 'Devotional Music Streaming Application',
      category: 'AUDIO & STREAMING',
      description:
          'A dedicated devotional music streaming application where users listen to spiritual bhajans, kirtans, and devotional songs with smooth playback and playlist management.',
      keyFeatures: [
        'Large collection of spiritual bhajans and kirtans',
        'Smooth music playback and streaming interface',
        'Custom playlist creation and audio queue control',
        'Clean, intuitive devotional listening experience',
      ],
      technologies: ['Flutter', 'Dart', 'Audio Streaming', 'REST APIs'],
      iconAsset: 'assets/images/projects/bhajan_kirtan_icon.png',
      screenshotAssets: [
        'assets/images/projects/bhajan_kirtan_screen1.png',
        'assets/images/projects/bhajan_kirtan_screen2.png',
        'assets/images/projects/bhajan_kirtan_screen3.png',
        'assets/images/projects/bhajan_kirtan_screen4.png',
      ],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.Rndtechnosoft.bhajankirtan',
      type: ProjectType.published,
    ),
  ];

  // Private Applications (Strictly confirmed features only)
  static const List<ProjectModel> privateProjects = [
    ProjectModel(
      id: 'saifee-distributor',
      title: 'Saifee Milk Distributor App',
      subtitle: 'Distributor Logistics & Inventory Management',
      category: 'COMMERCIAL DISTRIBUTION',
      description:
          'A dedicated distribution management application engineered for daily milk inventory logistics, distributor order handling, and routing operations.',
      keyFeatures: [
        'Distributor dashboard',
        'Order Management',
        'Milk inventory',
        'Delivery routes',
        'Customer management',
      ],
      technologies: ['Flutter', 'Dart', 'REST APIs', 'State Management'],
      iconAsset: '',
      screenshotAssets: [],
      type: ProjectType.privateWork,
    ),
    ProjectModel(
      id: 'saifee-driver',
      title: 'Saifee Milk Driver App',
      subtitle: 'Field Operations & OTP Delivery Application',
      category: 'LOGISTICS & DISPATCH',
      description:
          'A specialized field delivery mobile application designed for drivers to execute scheduled milk delivery routes, verify customer handoffs, and manage daily completion summaries.',
      keyFeatures: [
        'Driver login',
        'Delivery status',
        'Route management',
        'OTP Delivery',
        'Daily summary',
      ],
      technologies: ['Flutter', 'Dart', 'REST APIs', 'State Management'],
      iconAsset: '',
      screenshotAssets: [],
      type: ProjectType.privateWork,
    ),
  ];

  // Verified GitHub Repositories
  static const List<GitHubRepoModel> githubRepos = [
    GitHubRepoModel(
      name: 'cinebook',
      description: 'Cinema ticket booking application with interactive seat layout, movie showtimes, and booking confirmation flow.',
      language: 'Dart',
      url: 'https://github.com/Sudhanshu20d/cinebook',
      badge: 'FLUTTER',
    ),
    GitHubRepoModel(
      name: 'doctor_appointment',
      description: 'A Flutter doctor appointment booking app with date, slot selection, specialist listings, and confirmation screens.',
      language: 'Dart / C++',
      url: 'https://github.com/Sudhanshu20d/doctor_appointment',
      badge: 'MOBILE APP',
    ),
    GitHubRepoModel(
      name: 'Flutter---Offline-Database--Sqlite',
      description: 'State Management, Forms, API Integration, and Local Storage. Practical projects using setState, Provider, Riverpod, HTTP APIs, SharedPreferences, and Hive.',
      language: 'Dart',
      url: 'https://github.com/Sudhanshu20d/Flutter---Offline-Database--Sqlite',
      badge: 'OFFLINE & SQLITE',
    ),
    GitHubRepoModel(
      name: 'flutter-auth-app',
      description: 'Flutter authentication application implementing complete login & signup workflows with REST API integration.',
      language: 'Dart / C++',
      url: 'https://github.com/Sudhanshu20d/flutter-auth-app',
      badge: 'AUTH & APIS',
    ),
    GitHubRepoModel(
      name: 'HabitX',
      description: 'Habit tracking and daily routine builder mobile application engineered with Flutter & Dart.',
      language: 'Dart',
      url: 'https://github.com/Sudhanshu20d/HabitX',
      badge: 'FLUTTER',
    ),
  ];
}
