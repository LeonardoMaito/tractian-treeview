import 'component_model.dart';

class AssetModel {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final List<AssetModel> subAssets;
  final List<ComponentModel> components;

  AssetModel({
    required this.id,
    required this.name,
    this.subAssets = const [],
    this.components = const [],
    this.locationId,
    this.parentId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
        id: json['id'],
        name: json['name'],
        locationId: json['locationId'],
        parentId: json['parentId']);
  }

  void addSubAsset(AssetModel subAsset) {
    subAssets.add(subAsset);
  }

  void addComponent(ComponentModel component) {
    components.add(component);
  }
}
