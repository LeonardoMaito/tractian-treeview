import 'package:mobx/mobx.dart';
import 'package:treeview/features/asset_page/application/services/asset_location_service.dart';
import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import '../../domain/models/assets/component_model.dart';

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
        return entity.name.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    }

    if (filterEnergySensors) {
      filtered = filtered.where((entity) {
        if (entity is ComponentModel) {
          return entity.sensorType == ComponentType.energy;
        }
        return true;
      }).toList();
    }

    if (filterCriticalStatus) {
      filtered = filtered.where((entity) {
        if (entity is ComponentModel) {
          return entity.status == ComponentStatus.alert;
        }
        return true;
      }).toList();
    }

    //This is so that the parent entities, or the hierarchy path
    //is also included when getting the list of entities
    return ObservableList.of(_includeParentEntities(filtered));
  }

  List<BaseEntity> _includeParentEntities(List<BaseEntity> filteredEntities) {
    Set<BaseEntity> entitiesWithParents = filteredEntities.toSet();

    for (var entity in filteredEntities) {
      var parent = _findParentEntity(entity);
      while (parent != null) {
        entitiesWithParents.add(parent);
        parent = _findParentEntity(parent);
      }
    }

    return entitiesWithParents.toList();
  }

  BaseEntity? _findParentEntity(BaseEntity entity) {
    return entities.firstWhere((e) => e.id == entity.parentId);
  }
}