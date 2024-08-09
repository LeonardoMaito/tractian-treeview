import 'package:treeview/features/asset_page/data/datasource/asset/asset_datasource.dart';
import 'package:treeview/features/asset_page/domain/models/asset_model.dart';
import 'package:treeview/features/asset_page/domain/repository/asset_repository.dart';

import '../../../domain/models/i_asset.dart';

class AssetRepositoryImpl extends AssetRepository{
  final AssetDataSource dataSource;

  AssetRepositoryImpl(this.dataSource);

  @override
  Future<List<IAsset>> getAssets() async{
    return await dataSource.getAssets();
  }
}