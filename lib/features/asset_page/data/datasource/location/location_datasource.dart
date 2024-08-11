import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';

abstract class LocationDataSource {
  Future<List<LocationModel>> getLocations();
}