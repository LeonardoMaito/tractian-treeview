import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';

abstract class LocationRepository{
  Future<List<LocationModel>> getLocations();

}