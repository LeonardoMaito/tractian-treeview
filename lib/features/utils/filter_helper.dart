import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';
import 'package:treeview/features/asset_page/domain/models/assets/component_model.dart';

class FilterHelper {
  static List<BaseEntity> includeParentEntities(List<BaseEntity> filteredEntities, List<BaseEntity> allEntities) {
    Set<BaseEntity> entitiesWithParents = filteredEntities.toSet();

    for (var entity in filteredEntities) {
      var parent = _findParentEntity(entity, allEntities);
      while (parent != null && !entitiesWithParents.contains(parent)) {
        entitiesWithParents.add(parent);
        parent = _findParentEntity(parent, allEntities);
      }
    }

    return entitiesWithParents.toList();
  }

  static BaseEntity? _findParentEntity(BaseEntity entity, List<BaseEntity> allEntities) {
    try {
      return allEntities.firstWhere((e) => e.id == entity.parentId);
    } catch (e) {
      return null;
    }
  }

  static bool searchInEntity(BaseEntity entity, String term) {
    bool matches = entity.name.toLowerCase().contains(term.toLowerCase());

    if (entity is LocationModel) {
      // Verifica se qualquer sublocation ou asset corresponde ao termo de busca
      bool subLocationsMatch = entity.subLocations.any((subLocation) => searchInEntity(subLocation, term));
      bool assetsMatch = entity.assets.any((asset) => searchInEntity(asset, term));

      return matches || subLocationsMatch || assetsMatch;
    }

    if (entity is AssetModel) {
      // Verifica se qualquer sub-asset ou componente corresponde ao termo de busca
      bool subAssetsMatch = entity.subAssets.any((subAsset) => searchInEntity(subAsset, term));
      bool componentsMatch = entity.components.any((component) => component.name.toLowerCase().contains(term.toLowerCase()));

      return matches || subAssetsMatch || componentsMatch;
    }

    return matches;
  }

  static bool hasEnergySensor(BaseEntity entity) {
    if (entity is ComponentModel) {
      return entity.sensorType == ComponentType.energy;
    } else if (entity is AssetModel) {
      // Filtra apenas os sub-ativos e componentes que são de energia
      entity.subAssets = entity.subAssets.where((subAsset) => hasEnergySensor(subAsset)).toList();
      entity.components = entity.components.where((component) => component.sensorType == ComponentType.energy).toList();

      return entity.subAssets.isNotEmpty || entity.components.isNotEmpty;
    } else if (entity is LocationModel) {
      // Filtra apenas as sub-localizações e ativos que contêm componentes de energia
      entity.subLocations = entity.subLocations.where((subLocation) => hasEnergySensor(subLocation)).toList();
      entity.assets = entity.assets.where((asset) => hasEnergySensor(asset)).toList();

      return entity.subLocations.isNotEmpty || entity.assets.isNotEmpty;
    }
    return false;
  }

  static bool hasCriticalStatus(BaseEntity entity) {
    if (entity is ComponentModel) {
      return entity.status == ComponentStatus.alert;
    } else if (entity is AssetModel) {
      // Filtra apenas os sub-ativos e componentes que têm status crítico
      entity.subAssets = entity.subAssets.where((subAsset) => hasCriticalStatus(subAsset)).toList();
      entity.components = entity.components.where((component) => component.status == ComponentStatus.alert).toList();

      return entity.subAssets.isNotEmpty || entity.components.isNotEmpty;
    } else if (entity is LocationModel) {
      // Filtra apenas as sub-localizações e ativos que contêm componentes com status crítico
      entity.subLocations = entity.subLocations.where((subLocation) => hasCriticalStatus(subLocation)).toList();
      entity.assets = entity.assets.where((asset) => hasCriticalStatus(asset)).toList();

      return entity.subLocations.isNotEmpty || entity.assets.isNotEmpty;
    }
    return false;
  }

  static bool hasChildren(BaseEntity entity) {
    if (entity is LocationModel) {
      return entity.subLocations.isNotEmpty || entity.assets.isNotEmpty;
    } else if (entity is AssetModel) {
      return entity.subAssets.isNotEmpty || entity.components.isNotEmpty;
    }
    return false;
  }
}
