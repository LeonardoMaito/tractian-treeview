import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/application/services/asset_service.dart';
import 'package:treeview/features/asset_page/application/services/location_service.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';
import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/assets/component_model.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';

void main() {
  late LocalAssetDataSource localDataSource;
  late LocalLocationDatasource localLocationDatasource;

  late AssetRepositoryImpl assetRepository;
  late LocationRepositoryImpl locationRepository;

  late AssetService assetService;
  late LocationService locationService;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();

    localDataSource = LocalAssetDataSource('assets/tobias/assets.json');
    localLocationDatasource = LocalLocationDatasource('assets/tobias/locations.json');

    assetRepository = AssetRepositoryImpl(localDataSource);
    locationRepository = LocationRepositoryImpl(localLocationDatasource);

    assetService = AssetService(assetRepository);
    locationService = LocationService(locationRepository);
  });

  test('Categorize locations, assets, and components correctly', () async {
    List<AssetEntity> assets = await assetService.categorizeAssets();
    List<LocationModel> locations = await locationService.categorizeLocationsAndSubLocations();

    List<AssetEntity> unassignedAssets = [];

    for (var asset in assets) {
      bool assigned = false;

      for (var location in locations) {
        if (_assignAssetToLocation(asset, location)) {
          assigned = true;
          break;
        }
      }

      if (!assigned) {
        unassignedAssets.add(asset);
      }
    }

    List<BaseEntity> categorizedEntities = [];

    categorizedEntities.addAll(locations);

    categorizedEntities.addAll(unassignedAssets);

    printHierarchy(categorizedEntities);
  });
}

bool _assignAssetToLocation(AssetEntity asset, LocationModel location) {
  if (asset.locationId != null && asset.locationId == location.id) {
    location.addAsset(asset);
    return true;
  }

  for (var subLocation in location.subLocations!) {
    if (_assignAssetToLocation(asset, subLocation)) {
      return true;
    }
  }

  return false;
}

void printHierarchy(List<BaseEntity> entities, {int level = 0}) {
  for (var entity in entities) {
    String indent = '  ' * level;
    if (entity is LocationModel) {
      print('${indent}Location: ${entity.name}');
      if (entity.subLocations!.isNotEmpty) {
        printHierarchy(entity.subLocations!, level: level + 1);
      }
      if (entity.assets.isNotEmpty) {
        printHierarchy(entity.assets, level: level + 1);
      }
    } else if (entity is AssetModel) {
      print('${indent}Asset: ${entity.name}');
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
