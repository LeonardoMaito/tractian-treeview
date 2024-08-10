import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import '../../domain/models/asset_model.dart';
import '../../domain/models/component_model.dart';
import '../../domain/models/i_asset.dart';

class AssetService{
  final AssetRepositoryImpl assetRepository;

  AssetService(this.assetRepository);

  Future<List<IAsset>> categorizeAssets() async {
    List<IAsset> assets = await assetRepository.getAssets();

    List<AssetModel> assetModels = [];
    List<ComponentModel> componentModels = [];

    for (var asset in assets) {
      if (asset is AssetModel) {
        assetModels.add(asset);
      } else if (asset is ComponentModel) {
        componentModels.add(asset);
      }
    }

    Map<String, List<AssetModel>> subAssetsMap = {};

    for (var asset in assetModels) {
      if (asset.parentId != null) {
        subAssetsMap.putIfAbsent(asset.parentId!, () => []).add(asset);
      }
    }

    for (int i = 0; i < assetModels.length; i++) {
      AssetModel asset = assetModels[i];

      if (subAssetsMap.containsKey(asset.id)) {
        assetModels[i] = asset.copyWith(subAssets: subAssetsMap[asset.id]!);
      }

      var assetComponents = componentModels.where((component) => component.parentId == asset.id).toList();
      if (assetComponents.isNotEmpty) {
        assetModels[i] = asset.copyWith(components: assetComponents);
      }
    }

    List<IAsset> finalAssets = [...assetModels, ...componentModels.where((c) => c.parentId == null)];

    return finalAssets;
  }
}