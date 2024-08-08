import 'package:treeview/features/asset_page/domain/models/asset_model.dart';

abstract class AssetRepository{
  Future<List<AssetModel>> getAssets();

}