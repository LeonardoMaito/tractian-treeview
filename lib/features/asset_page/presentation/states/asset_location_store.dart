import 'package:mobx/mobx.dart';
import 'package:treeview/features/asset_page/application/services/asset_location_service.dart';
import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import 'package:treeview/features/utils/filter_helper.dart';

part 'asset_location_store.g.dart';

class AssetLocationStore = _AssetLocationStore with _$AssetLocationStore;

abstract class _AssetLocationStore with Store {
  final AssetLocationService assetLocationService;

  _AssetLocationStore(this.assetLocationService);

  @observable
  ObservableList<BaseEntity> entities = ObservableList<BaseEntity>();

  @observable
  String searchTerm = '';

  @observable
  bool filterEnergySensors = false;

  @observable
  bool filterCriticalStatus = false;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadAssetsAndLocations() async {
    isLoading = true;

    try {
      final loadedAssets = await assetLocationService.buildEntityHierarchy();
      entities.clear();
      entities.addAll(loadedAssets);
    } catch (e) {
      throw Exception('Error loading assets: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  void setSearchTerm(String term) {
    searchTerm = term;
  }

  @action
  void toggleEnergySensorsFilter() {
    filterEnergySensors = !filterEnergySensors;
  }

  @action
  void toggleCriticalStatusFilter() {
    filterCriticalStatus = !filterCriticalStatus;
  }

  @computed
  ObservableList<BaseEntity> get filteredEntities {
    List<BaseEntity> filtered = entities.toList();

    if (searchTerm.isNotEmpty) {
      filtered = FilterHelper.filterBySearchTerm(filtered, searchTerm);
    }

    if (filterEnergySensors) {
      filtered = FilterHelper.filterByEnergySensor(filtered);
    }

    if (filterCriticalStatus) {
      filtered = FilterHelper.filterByCriticalStatus(filtered);
    }

    filtered = FilterHelper.includeParentEntities(filtered, entities);

    return ObservableList.of(filtered);
  }
}
