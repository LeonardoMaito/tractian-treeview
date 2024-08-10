
import 'asset_model.dart';

class LocationModel {
  final String name;
  final String id;
  final String? parentId;
  final List<LocationModel> subLocations;
  final List<AssetModel> assets;

  LocationModel({
    required this.id,
    required this.name,
    this.parentId,
    this.subLocations = const [],
    this.assets = const [],
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        id: json['id'],
        name: json['name'],
        parentId: json['parentId']);
  }

  LocationModel copyWith({
    List<LocationModel>? subLocations,
    List<AssetModel>? assets,
  }) {
    return LocationModel(
      id: id,
      name: name,
      parentId: parentId,
      subLocations: subLocations ?? this.subLocations,
      assets: assets ?? this.assets,
    );
  }
}