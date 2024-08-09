import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/component_model.dart';
import 'package:treeview/features/asset_page/domain/models/i_asset.dart';
import 'package:treeview/features/asset_page/domain/models/location_model.dart';

void main() {

  late LocalAssetDataSource localDataSource;
  late LocalLocationDatasource localLocationDatasource;
  late AssetRepositoryImpl assetRepository;
  late LocationRepositoryImpl locationRepository;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    localDataSource = LocalAssetDataSource('assets/jaguar/assets.json');
    localLocationDatasource = LocalLocationDatasource('assets/jaguar/locations.json');
    assetRepository = AssetRepositoryImpl(localDataSource);
    locationRepository = LocationRepositoryImpl(localLocationDatasource);
  });

  test('Categorize locations, assets and components correctly', () async{

    List<IAsset> assets = await assetRepository.getAssets();
    List<LocationModel> locations = await locationRepository.getLocations();
    List<ComponentModel> components = [];

  });

}