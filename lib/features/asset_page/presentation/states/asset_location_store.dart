import 'package:mobx/mobx.dart';
import 'package:treeview/features/asset_page/application/services/asset_location_service.dart';
import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import 'package:treeview/features/utils/filter_helper.dart';

part 'asset_location_store.g.dart';

class AssetLocationStore = _AssetLocationStore with _$AssetLocationStore;

abstract class _AssetLocationStore with Store{
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

  @action
  Future<void> loadAssetsAndLocations() async {
    final loadedAssets = await assetLocationService.buildEntityHierarchy();
    entities.addAll(loadedAssets);
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
    List<BaseEntity> filtered = entities;

    if (searchTerm.isNotEmpty) {
      filtered = filtered.where((entity) {
        return FilterHelper.searchInEntity(entity, searchTerm);
      }).toList();
    }

    if (filterEnergySensors) {
      filtered = filtered.where((entity) {
        return FilterHelper.hasEnergySensor(entity);
      }).toList();
    }

    if (filterCriticalStatus) {
      filtered = filtered.where((entity) {
        return FilterHelper.hasCriticalStatus(entity);
      }).toList();
    }

    //This is so that the parent entities, or the hierarchy path
    //is also included when getting the list of entities
    return ObservableList.of(FilterHelper.includeParentEntities(filtered, entities));
  }
}