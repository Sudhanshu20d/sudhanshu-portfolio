import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudhanshu_portfolio/core/constants/portfolio_data.dart';
import 'package:sudhanshu_portfolio/main.dart';

void main() {
  test('Portfolio data verification test', () {
    expect(PortfolioData.name, 'Sudhanshu Singh');
    expect(PortfolioData.monogram, 'SD');
    expect(PortfolioData.company, 'RND Technosoft');
    expect(PortfolioData.publishedProjects.length, 2);
    expect(PortfolioData.privateProjects.length, 2);
    expect(PortfolioData.githubRepos.length, 5);

    final vapiProject = PortfolioData.publishedProjects.firstWhere(
      (p) => p.id == 'vapi-startup-community',
    );
    expect(
      vapiProject.playStoreUrl,
      'https://play.google.com/store/apps/details?id=com.app.mycitycommunity&pcampaignid=web_share',
    );
    expect(
      vapiProject.appStoreUrl,
      'https://apps.apple.com/us/app/vapi-startup-community/id6759277348',
    );

    final bhajanProject = PortfolioData.publishedProjects.firstWhere(
      (p) => p.id == 'bhajan-kirtan',
    );
    expect(bhajanProject.playStoreUrl, isNotNull);
    expect(bhajanProject.appStoreUrl, isNull);
  });

  const viewports = [
    Size(320, 700),
    Size(360, 780),
    Size(375, 812),
    Size(390, 844),
    Size(768, 1024),
    Size(1280, 800),
  ];

  for (final vp in viewports) {
    testWidgets('Renders without overflow at ${vp.width.toInt()}x${vp.height.toInt()}', (tester) async {
      tester.view.physicalSize = vp;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      FlutterErrorDetails? caught;
      final oldOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        caught = details;
      };

      await tester.pumpWidget(const PortfolioApp());
      await tester.pump(const Duration(milliseconds: 500));

      FlutterError.onError = oldOnError;
      expect(caught, isNull, reason: 'Caught layout/render exception: ${caught?.exception}');
      expect(tester.takeException(), isNull);
      expect(find.textContaining('SUDHANSHU'), findsWidgets);
    });
  }
}
