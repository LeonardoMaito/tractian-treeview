import '../entities/asset_entity.dart';

abstract class AssetRepository{
  Future<List<AssetEntity>> getAssets();

}