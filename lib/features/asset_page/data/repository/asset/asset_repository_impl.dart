import 'package:treeview/features/asset_page/data/datasource/asset/asset_datasource.dart';
import 'package:treeview/features/asset_page/domain/repository/asset_repository.dart';
import '../../../domain/entities/asset_entity.dart';

class AssetRepositoryImpl extends AssetRepository{
  final AssetDataSource dataSource;

  AssetRepositoryImpl(this.dataSource);

  @override
  Future<List<AssetEntity>> getAssets() async{
    return await dataSource.getAssets();
  }
}