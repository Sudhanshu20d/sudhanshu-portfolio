import 'package:flutter_test/flutter_test.dart';
import 'package:sudhanshu_portfolio/core/constants/portfolio_data.dart';

void main() {
  test('Portfolio data verification test', () {
    expect(PortfolioData.name, 'Sudhanshu Singh');
    expect(PortfolioData.monogram, 'SD');
    expect(PortfolioData.company, 'RND Technosoft');
    expect(PortfolioData.publishedProjects.length, 2);
    expect(PortfolioData.privateProjects.length, 2);
    expect(PortfolioData.githubRepos.length, 5);
  });
}
