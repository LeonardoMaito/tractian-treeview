import 'component_model.dart';
import 'i_asset.dart';

class AssetModel implements IAsset {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? locationId;

  @override
  final String? parentId;

  final List<IAsset> subAssets;
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

  AssetModel copyWith({
    List<AssetModel>? subAssets,
    List<ComponentModel>? components,
  }) {
    return AssetModel(
      id: id,
      name: name,
      locationId: locationId,
      parentId: parentId,
      subAssets: subAssets ?? this.subAssets,
      components: components ?? this.components,
    );
  }
}

