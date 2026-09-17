class ExperienceModel {
  final String index;
  final String company;
  final String role;
  final String location;
  final String status;
  final String summary;
  final List<String> technologies;

  const ExperienceModel({
    required this.index,
    required this.company,
    required this.role,
    required this.location,
    required this.status,
    required this.summary,
    required this.technologies,
  });
}
