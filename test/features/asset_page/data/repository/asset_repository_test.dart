import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';

void main() {

  late LocalAssetDataSource localDataSource;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
     localDataSource = LocalAssetDataSource('assets/jaguar/assets.json');
  });

  test('Get assets from local datasource', () async{
    final assets = await localDataSource.getAssets();

    expect(assets.isNotEmpty, true);
    expect(assets.first.name.toLowerCase(), 'conveyor belt assembly');
  });

  test('Parse JSON correctly into AssetModel', () async {
    final assets = await localDataSource.getAssets();

    expect(assets, isA<List<AssetModel>>());
  });

}