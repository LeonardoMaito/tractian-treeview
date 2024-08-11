import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';
import 'component_model.dart';

class AssetModel extends AssetEntity {
  List<AssetModel> subAssets;
  List<ComponentModel> components;

  AssetModel({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    List<AssetModel>? subAssets,
    List<ComponentModel>? components,
  })  : subAssets = subAssets ?? [],
        components = components ?? [];

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
    );
  }

  void addSubAsset(AssetModel subAsset) {
    subAssets.add(subAsset);
  }

  void addComponent(ComponentModel component) {
    components.add(component);
  }
}
