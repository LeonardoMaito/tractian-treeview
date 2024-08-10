import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/models/location_model.dart';

void main() {

  late LocalLocationDatasource localDataSource;
  late LocationRepositoryImpl locationRepository;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    localDataSource = LocalLocationDatasource('assets/jaguar/locations.json');
    locationRepository = LocationRepositoryImpl(localDataSource);
  });

  test('Get locations from local datasource', () async{
    final locations = await locationRepository.getLocations();

    expect(locations.isNotEmpty, true);
    expect(locations.first.name.toLowerCase(), 'charcoal storage sector');
  });

  test('Parse JSON correctly into LocationModel', () async {
    final locations = await locationRepository.getLocations();

    expect(locations, isA<List<LocationModel>>());
  });

}