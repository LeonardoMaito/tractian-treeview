import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';
import '../../domain/models/assets/asset_model.dart';
import '../../domain/models/assets/component_model.dart';

class AssetService{
  final AssetRepositoryImpl assetRepository;

  AssetService(this.assetRepository);

  Future<List<AssetEntity>> categorizeAssets() async {
    List<AssetEntity> assets = await assetRepository.getAssets();

    List<AssetModel> assetModels = [];
    List<ComponentModel> componentModels = [];

    for (var asset in assets) {
      if (asset is AssetModel) {
        assetModels.add(asset);
      } else if (asset is ComponentModel) {
        componentModels.add(asset);
      }
    }

    Map<String, AssetModel> assetMap = {for (var asset in assetModels) asset.id: asset};

    for (var component in componentModels) {
      if (component.parentId != null && assetMap.containsKey(component.parentId)) {
        assetMap[component.parentId]!.addComponent(component);
      }
    }

    for (var asset in assetModels) {
      if (asset.parentId != null && assetMap.containsKey(asset.parentId)) {
        assetMap[asset.parentId]!.addSubAsset(asset);
      }
    }



    List<AssetEntity> finalAssets = [
      ...assetModels.where((asset) => asset.parentId == null),
      ...componentModels.where((component) => component.parentId == null),
    ];

    return finalAssets;
  }
}