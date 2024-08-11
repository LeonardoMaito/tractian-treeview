import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';

abstract class AssetDataSource {
  Future<List<AssetEntity>> getAssets();
}