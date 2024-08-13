import 'package:treeview/features/asset_page/application/services/asset_service.dart';
import 'package:treeview/features/asset_page/application/services/location_service.dart';
import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import '../../../utils/filter_helper.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/models/location/location_model.dart';

class AssetLocationService {
  final AssetService assetService;
  final LocationService locationService;

  AssetLocationService(this.assetService, this.locationService);

  Future<List<BaseEntity>> buildEntityHierarchy() async {
    List<AssetEntity> assets = await assetService.categorizeAssets();
    List<LocationModel> locations = await locationService.categorizeLocationsAndSubLocations();

    List<AssetEntity> unassignedAssets = [];

    for (var asset in assets) {
      bool assigned = false;

      for (var location in locations) {
        if (_assignAssetToLocation(asset, location)) {
          assigned = true;
          break;
        }
      }

      if (!assigned) {
        unassignedAssets.add(asset);
      }
    }

    List<BaseEntity> categorizedEntities = [];

    categorizedEntities.addAll(locations);

    categorizedEntities.addAll(unassignedAssets);

    categorizedEntities.sort((a, b) {
      int aHasChildren = FilterHelper.hasChildren(a) ? 0 : 1;
      int bHasChildren = FilterHelper.hasChildren(b) ? 0 : 1;
      return aHasChildren.compareTo(bHasChildren);
    });

    return categorizedEntities;
  }

  bool _assignAssetToLocation(AssetEntity asset, LocationModel location) {
    if (asset.locationId != null && asset.locationId == location.id) {
      location.addAsset(asset);
      return true;
    }
    for (var subLocation in location.subLocations) {
      if (_assignAssetToLocation(asset, subLocation)) {
        return true;
      }
    }
    return false;
  }
}