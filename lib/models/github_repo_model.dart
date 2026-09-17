class GitHubRepoModel {
  final String name;
  final String description;
  final String language;
  final String url;
  final String badge;

  const GitHubRepoModel({
    required this.name,
    required this.description,
    required this.language,
    required this.url,
    required this.badge,
  });
}
