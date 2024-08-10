import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/application/services/location_service.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/location_model.dart';

void main() {
  late LocalLocationDatasource localLocationDatasource;
  late LocationRepositoryImpl locationRepository;
  late LocationService locationService;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    localLocationDatasource = LocalLocationDatasource('assets/jaguar/locations.json');
    locationRepository = LocationRepositoryImpl(localLocationDatasource);
    locationService = LocationService(locationRepository);
  });

  test('Should categorize locations and sub-locations correctly', () async {
    List<LocationModel> organizedLocations = await locationService.categorizeLocationsAndSubLocations();

    expect(organizedLocations.isNotEmpty, true);
    var locationWithSubLocations = organizedLocations.firstWhere((loc) => loc.subLocations.isNotEmpty);
    expect(locationWithSubLocations.subLocations.isNotEmpty, true);
  });
}
