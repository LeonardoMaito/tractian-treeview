import 'package:treeview/features/asset_page/domain/models/i_asset.dart';

abstract class AssetDataSource {
  Future<List<IAsset>> getAssets();
}