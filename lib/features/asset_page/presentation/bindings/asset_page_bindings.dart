import 'package:get_it/get_it.dart';
import 'package:treeview/features/asset_page/application/services/asset_location_service.dart';
import 'package:treeview/features/asset_page/application/services/asset_service.dart';
import 'package:treeview/features/asset_page/application/services/location_service.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/asset_datasource.dart';
import 'package:treeview/features/asset_page/data/datasource/asset/local_asset_datasource.dart';
import 'package:treeview/features/asset_page/data/datasource/location/local_location_datasource.dart';
import 'package:treeview/features/asset_page/data/datasource/location/location_datasource.dart';
import 'package:treeview/features/asset_page/data/repository/asset/asset_repository_impl.dart';
import 'package:treeview/features/asset_page/data/repository/location/location_repository_impl.dart';
import 'package:treeview/features/asset_page/domain/repository/asset_repository.dart';
import 'package:treeview/features/asset_page/domain/repository/location_repository.dart';
import 'package:treeview/features/asset_page/presentation/states/asset_location_store.dart';
import 'package:treeview/features/home_page/domain/models/company_model.dart';

class AssetPageBindings{
  final i = GetIt.instance;

  void init(CompanyModel company) {
    i.registerFactory<AssetDataSource>(() => LocalAssetDataSource(company.assetPath));
    i.registerFactory<LocationDataSource>(() => LocalLocationDatasource(company.locationPath));

    i.registerFactory<AssetRepository>(() => AssetRepositoryImpl(i<AssetDataSource>()));
    i.registerFactory<LocationRepository>(() => LocationRepositoryImpl(i<LocationDataSource>()));

    i.registerFactory<AssetService>(() => AssetService(i<AssetRepository>()));
    i.registerFactory<LocationService>(() => LocationService(i<LocationRepository>()));
    i.registerFactory<AssetLocationService>(() => AssetLocationService(i<AssetService>(), i<LocationService>()));

    i.registerFactory<AssetLocationStore>(() => AssetLocationStore(i<AssetLocationService>()));

  }

  void dispose() {
      i.unregister<AssetLocationStore>();

      i.unregister<AssetLocationService>();
      i.unregister<AssetService>();
      i.unregister<LocationService>();


      i.unregister<AssetRepository>();
      i.unregister<LocationRepository>();

      i.unregister<AssetDataSource>();
      i.unregister<LocationDataSource>();

  }
}