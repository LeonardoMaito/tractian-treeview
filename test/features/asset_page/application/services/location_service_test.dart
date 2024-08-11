import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';

void main() {
  late LocalLocationDatasource localLocationDatasource;
  late LocationRepositoryImpl locationRepository;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    localLocationDatasource = LocalLocationDatasource('assets/jaguar/locations.json');
    locationRepository = LocationRepositoryImpl(localLocationDatasource);
  });

  test('Should categorize locations and sub-locations correctly', () async {

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

    expect(rootLocations.isNotEmpty, true);
    var locationWithSubLocations = rootLocations.firstWhere((loc) => loc.subLocations.isNotEmpty);
    expect(locationWithSubLocations.subLocations.isNotEmpty, true);

    printHierarchy(rootLocations);
  });
}

void printHierarchy(List<LocationModel> locations, {int level = 0}) {
  for (LocationModel location in locations) {
    String indent = '  ' * level;
    debugPrint('${indent}Location: ${location.name}');
    if (location.subLocations.isNotEmpty) {
      printHierarchy(location.subLocations, level: level + 1);
    }
  }
}