import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudhanshu_portfolio/core/animations/letter_reveal.dart';
import 'package:sudhanshu_portfolio/sections/experience/experience_section.dart';

void main() {
  testWidgets('Tight headline leading preserves the full font descent', (
    tester,
  ) async {
    final loader = FontLoader('HeadlineTest')
      ..addFont(rootBundle.load('assets/fonts/SpaceGrotesk-Bold.ttf'));
    await loader.load();
    const style = TextStyle(
      fontFamily: 'HeadlineTest',
      fontSize: 112,
      height: 0.95,
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              LetterReveal('g', style: style),
              Text(
                'g',
                key: Key('natural'),
                style: TextStyle(fontFamily: 'HeadlineTest', fontSize: 112, height: 1),
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 2));
    final revealed = find.descendant(
      of: find.byType(LetterReveal),
      matching: find.byType(Text),
    );
    expect(
      tester.getSize(revealed).height,
      closeTo(tester.getSize(find.byKey(const Key('natural'))).height, 0.1),
    );
    expect(tester.takeException(), isNull);
  });

  for (final width in [320.0, 1280.0]) {
    testWidgets('Employment types remain distinct at width $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: ExperienceSection()),
          ),
        ),
      );
      expect(find.text('RND Technosoft'), findsOneWidget);
      expect(find.text('AGB Software'), findsOneWidget);
      expect(find.text('Suess Innovative'), findsOneWidget);
      expect(find.text('FULL-TIME'), findsOneWidget);
      expect(find.text('FREELANCE'), findsOneWidget);
      expect(find.text('PREVIOUS'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
