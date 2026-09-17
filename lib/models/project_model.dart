enum ProjectType { published, privateWork }

class ProjectModel {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String description;
  final List<String> keyFeatures;
  final List<String> technologies;
  final String iconAsset;
  final List<String> screenshotAssets;
  final String? playStoreUrl;
  final String? githubUrl;
  final ProjectType type;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.description,
    required this.keyFeatures,
    required this.technologies,
    required this.iconAsset,
    required this.screenshotAssets,
    this.playStoreUrl,
    this.githubUrl,
    this.type = ProjectType.published,
  });
}
