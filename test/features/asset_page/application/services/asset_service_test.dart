import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/assets/component_model.dart';

void main() {
  late LocalAssetDataSource localAssetDataSource;
  late AssetRepositoryImpl assetRepository;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    localAssetDataSource = LocalAssetDataSource('assets/jaguar/assets.json');
    assetRepository = AssetRepositoryImpl(localAssetDataSource);
  });

  test('Should categorize assets, subAssets and components correctly', () async {

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

    printHierarchy(finalAssets);

    return finalAssets;
  });
}

void printHierarchy(List<AssetEntity> entities, {int level = 0}) {
  for (var entity in entities) {
    String indent = '  ' * level;
    if (entity is AssetModel) {
      debugPrint('${indent}Asset: ${entity.name}');
      if (entity.subAssets.isNotEmpty) {
        printHierarchy(entity.subAssets, level: level + 1);
      }
      if (entity.components.isNotEmpty) {
        printHierarchy(entity.components, level: level + 1);
      }
    } else if (entity is ComponentModel) {
      print('${indent}Component: ${entity.name}');
    }
  }
}
