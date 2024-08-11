import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';
import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';

class LocationModel extends BaseEntity {
  List<LocationModel> subLocations;
  List<AssetEntity> assets;

  LocationModel({
    required super.id,
    required super.name,
    super.parentId,
    List<LocationModel>? subLocations,
    List<AssetEntity>? assets,
  })  : subLocations = subLocations ?? [],
        assets = assets ?? [];

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  void addSubLocation(LocationModel location) {
    subLocations.add(location);
  }

  void addAsset(AssetEntity asset) {
    assets.add(asset);
  }
}
