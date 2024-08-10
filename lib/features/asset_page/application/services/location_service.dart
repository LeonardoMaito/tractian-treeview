import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/location_model.dart';

class LocationService {
  final LocationRepositoryImpl locationRepository;

  LocationService(this.locationRepository);

  Future<List<LocationModel>> categorizeLocationsAndSubLocations() async {
    List<LocationModel> locations = await locationRepository.getLocations();

    Map<String, List<LocationModel>> subLocationsMap = {};

    for (LocationModel location in locations) {
      if (location.parentId != null) {
        subLocationsMap.putIfAbsent(location.parentId!, () => []).add(location);
      }
    }

    for (int i = 0; i < locations.length; i++) {
      LocationModel location = locations[i];
      if (subLocationsMap.containsKey(location.id)) {
        locations[i] = location.copyWith(subLocations: subLocationsMap[location.id]!);
      }
    }
    return locations;
  }
}