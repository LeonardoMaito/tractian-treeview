import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/component_model.dart';
import 'package:treeview/features/asset_page/domain/models/i_asset.dart';

void main() {
  late LocalAssetDataSource localAssetDataSource;
  late AssetRepositoryImpl assetRepository;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    localAssetDataSource = LocalAssetDataSource('assets/jaguar/assets.json');
    assetRepository = AssetRepositoryImpl(localAssetDataSource);
  });

  test('Should categorize assets, subAssets and components correctly', () async {
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

  });
}
