import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudhanshu_portfolio/sections/projects/featured_projects.dart';

void main() {
  testWidgets(
    'Desktop hover keeps screenshots in the gallery without a popup',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: FeaturedProjectsSection()),
          ),
        ),
      );
      await tester.runAsync(() => GoogleFonts.pendingFonts());
      await tester.pumpAndSettle();

      final iphone = find.image(
        const AssetImage('assets/images/projects/vapi_iphone_screen1.jpg'),
      );
      expect(iphone, findsOneWidget);
      final originalPosition = tester.getTopLeft(iphone);
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      addTearDown(mouse.removePointer);
      await mouse.moveTo(tester.getCenter(iphone));
      await tester.pumpAndSettle();
      expect(
        iphone,
        findsOneWidget,
        reason: 'Hover must not create a floating duplicate',
      );
      expect(tester.getTopLeft(iphone), originalPosition);

      await mouse.moveTo(tester.getCenter(find.text('Android / Google Play')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Android / Google Play'));
      await tester.pumpAndSettle();
      expect(
        iphone,
        findsNothing,
        reason: 'No stale iPhone preview after changing platform',
      );
      final android = find.image(
        const AssetImage('assets/images/projects/vapi_startup_screen1.png'),
      );
      await mouse.moveTo(tester.getCenter(android));
      await tester.pumpAndSettle();
      expect(android, findsOneWidget);

      final next = find.byTooltip('Next StartupVapi Community screenshots');
      await tester.ensureVisible(next);
      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(
        find.image(
          const AssetImage('assets/images/projects/vapi_startup_screen4.png'),
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
