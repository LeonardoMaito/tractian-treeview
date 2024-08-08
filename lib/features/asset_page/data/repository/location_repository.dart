import 'package:treeview/features/asset_page/domain/models/location_model.dart';

abstract class LocationRepository{
  Future<List<LocationModel>> getLocations();

}