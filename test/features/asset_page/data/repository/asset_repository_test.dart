import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/asset_model.dart';

void main() {

  late LocalAssetDataSource localDataSource;
  late AssetRepositoryImpl assetRepository;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
     localDataSource = LocalAssetDataSource('assets/jaguar/assets.json');
     assetRepository = AssetRepositoryImpl(localDataSource);
  });

  test('Get assets from local datasource', () async{
    final assets = await assetRepository.getAssets();

    expect(assets.isNotEmpty, true);
    expect(assets.first.name.toLowerCase(), 'conveyor belt assembly');
  });

  test('Parse JSON correctly into AssetModel', () async {
    final assets = await assetRepository.getAssets();

    expect(assets, isA<List<AssetModel>>());
  });

}