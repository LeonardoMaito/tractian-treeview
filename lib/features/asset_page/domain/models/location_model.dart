
class LocationModel {
  final String name;
  final String id;
  final String? parentId;
  List<LocationModel> subLocations;

  LocationModel({
    required this.id,
    required this.name,
    this.parentId,
    this.subLocations = const [],
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        id: json['id'],
        name: json['name'],
        parentId: json['parentId']);
  }

  LocationModel copyWith({
    List<LocationModel>? subLocations,
  }) {
    return LocationModel(
      id: id,
      name: name,
      parentId: parentId,
      subLocations: subLocations ?? this.subLocations,
    );
  }
}