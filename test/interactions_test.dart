import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:sudhanshu_portfolio/main.dart';
import 'package:sudhanshu_portfolio/core/widgets/accessible_action.dart';
import 'package:sudhanshu_portfolio/core/theme/app_colors.dart';
import 'package:sudhanshu_portfolio/sections/projects/featured_projects.dart';

void main() {
  setUpAll(
    () => VisibilityDetectorController.instance.updateInterval = Duration.zero,
  );

  testWidgets('StartupVapi gallery switches between official iPhone and existing Android screenshots', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() { tester.view.resetPhysicalSize(); tester.view.resetDevicePixelRatio(); });
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SingleChildScrollView(child: FeaturedProjectsSection()))));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.image(const AssetImage('assets/images/projects/vapi_iphone_screen1.jpg')), findsOneWidget);
    await tester.tap(find.text('Android / Google Play'));
    await tester.pump();
    expect(find.image(const AssetImage('assets/images/projects/vapi_startup_screen1.png')), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/projects/vapi_iphone_screen1.jpg')), findsNothing);
    await tester.ensureVisible(find.byTooltip('Next StartupVapi Community screenshots'));
    await tester.tap(find.byTooltip('Next StartupVapi Community screenshots'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.image(const AssetImage('assets/images/projects/vapi_startup_screen4.png')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  Future<void> openPortfolio(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(seconds: 2));
  }

  testWidgets('Mobile resume retains all actions and closes at 320px', (
    tester,
  ) async {
    await openPortfolio(tester, const Size(320, 700));
    await tester.tap(find.text('RESUME ↗').last);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('DOWNLOAD RESUME PDF ↗'), findsOneWidget);
    expect(find.text('View GitHub Profile'), findsOneWidget);
    expect(find.text('Direct Email'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byIcon(Icons.close_rounded).last);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('DOWNLOAD RESUME PDF ↗'), findsNothing);
  });

  testWidgets('Drawer remains usable in small landscape and scrolls to About', (
    tester,
  ) async {
    await openPortfolio(tester, const Size(568, 320));
    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pump();
    expect(find.text('INDEX / NAVIGATION'), findsOneWidget);
    await tester.ensureVisible(find.text('About').last);
    await tester.tap(find.text('About').last);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('INDEX / NAVIGATION'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Selected-project sheet preserves title and GitHub action', (
    tester,
  ) async {
    await openPortfolio(tester, const Size(320, 700));
    await Scrollable.ensureVisible(
      tester.element(find.text('Animal Pop Kids')),
      alignment: 0.35,
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('Animal Pop Kids'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Animal Pop Kids'), findsNWidgets(2));
    expect(find.text('View on GitHub ↗'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('View on GitHub ↗'), findsNothing);
  });

  testWidgets('Keyboard visitors can activate existing tap controls', (
    tester,
  ) async {
    var activated = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccessibleAction(
            onTap: () => activated = true,
            child: const Text('View Projects ↓'),
          ),
        ),
      ),
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(activated, isTrue);
  });

  testWidgets('System palette switches and reduced motion keeps hero visible', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(() {
      tester.platformDispatcher.clearPlatformBrightnessTestValue();
      tester.platformDispatcher.clearAccessibilityFeaturesTestValue();
    });
    await openPortfolio(tester, const Size(1280, 800));
    expect(AppColors.background, const Color(0xFF0B0B0C));
    expect(
      find.text('Building mobile products that people actually use.'),
      findsOneWidget,
    );
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pump();
    expect(AppColors.background, const Color(0xFFEFEFEC));
    expect(tester.takeException(), isNull);
  });
}
