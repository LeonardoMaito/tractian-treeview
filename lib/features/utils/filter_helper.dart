import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';
import 'package:treeview/features/asset_page/domain/models/assets/component_model.dart';

class FilterHelper {

  static List<BaseEntity> includeParentEntities(List<BaseEntity> filteredEntities, List<BaseEntity> allEntities) {
    Set<BaseEntity> entitiesWithParents = filteredEntities.toSet();

    for (var entity in filteredEntities) {
      var parent = _findParentEntity(entity, allEntities);
      while (parent != null) {
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
    if (entity.name.toLowerCase().contains(term.toLowerCase())) {
      return true;
    }

    if (entity is LocationModel) {
      return entity.subLocations.any((subLocation) => searchInEntity(subLocation, term)) ||
          entity.assets.any((asset) => searchInEntity(asset, term));
    }

    if (entity is AssetModel) {
      return entity.subAssets.any((subAsset) => searchInEntity(subAsset, term)) ||
          entity.components.any((component) => component.name.toLowerCase().contains(term.toLowerCase()));
    }

    return false;
  }

  static bool hasEnergySensor(BaseEntity entity) {
    if (entity is ComponentModel && entity.sensorType == ComponentType.energy) {
      return true;
    }

    if (entity is LocationModel) {
      return entity.subLocations.any(hasEnergySensor) ||
          entity.assets.any(hasEnergySensor);
    }

    if (entity is AssetModel) {
      return entity.components.any((component) => component.sensorType == ComponentType.energy) ||
          entity.subAssets.any(hasEnergySensor);
    }

    return false;
  }

  static bool hasCriticalStatus(BaseEntity entity) {
    if (entity is ComponentModel && entity.status == ComponentStatus.alert) {
      return true;
    }

    if (entity is LocationModel) {
      return entity.subLocations.any(hasCriticalStatus) ||
          entity.assets.any(hasCriticalStatus);
    }

    if (entity is AssetModel) {
      return entity.components.any((component) => component.status == ComponentStatus.alert) ||
          entity.subAssets.any(hasCriticalStatus);
    }

    return false;
  }
}
