import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';

class LocationService {
  final LocationRepositoryImpl locationRepository;

  LocationService(this.locationRepository);

  Future<List<LocationModel>> categorizeLocationsAndSubLocations() async {
    List<LocationModel> locations = await locationRepository.getLocations();

    Map<String, LocationModel> locationMap = {
      for (var location in locations) location.id: location
    };

    for (var location in locations) {
      if (location.parentId != null && locationMap.containsKey(location.parentId)) {
        locationMap[location.parentId]!.addSubLocation(location);
      }
    }

    List<LocationModel> rootLocations = locations.where((location) => location.parentId == null).toList();

    return rootLocations;
  }
}