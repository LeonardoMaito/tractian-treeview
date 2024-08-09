import '../models/i_asset.dart';

abstract class AssetRepository{
  Future<List<IAsset>> getAssets();

}