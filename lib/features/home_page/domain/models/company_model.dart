class CompanyModel {
  final String id;
  final String name;
  final String assetPath;
  final String locationPath;

  CompanyModel({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.locationPath,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      assetPath: json['assetPath'],
      locationPath: json['locationPath'],
    );
  }
}
