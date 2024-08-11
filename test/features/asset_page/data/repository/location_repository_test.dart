import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';

void main() {

  late LocalLocationDatasource localDataSource;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    localDataSource = LocalLocationDatasource('assets/jaguar/locations.json');
  });

  test('Get locations from local datasource', () async{
    final locations = await  localDataSource.getLocations();

    expect(locations.isNotEmpty, true);
    expect(locations.first.name.toLowerCase(), 'charcoal storage sector');
  });

  test('Parse JSON correctly into LocationModel', () async {
    final locations = await localDataSource.getLocations();

    expect(locations, isA<List<LocationModel>>());
  });

}