import 'package:treeview/features/asset_page/data/datasource/location/location_datasource.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';
import 'package:treeview/features/asset_page/domain/repository/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository{
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<List<LocationModel>> getLocations() async {
    return dataSource.getLocations();
  }
}