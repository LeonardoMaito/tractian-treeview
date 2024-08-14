import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';
import 'package:treeview/features/asset_page/domain/models/assets/component_model.dart';
import '../asset_page/domain/entities/asset_entity.dart';

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

  static List<BaseEntity> filterBySearchTerm(List<BaseEntity> entities, String searchTerm) {
    return entities.expand((entity) {
      return _filterEntityBySearchTerm(entity, searchTerm);
    }).toList();
  }

  static List<BaseEntity> _filterEntityBySearchTerm(BaseEntity entity, String searchTerm) {
    final searchPattern = RegExp(r'\b' + RegExp.escape(searchTerm), caseSensitive: false);

    // Verificar se a entidade corresponde ao padrão
    bool matches = searchPattern.hasMatch(entity.name);

    if (entity is LocationModel) {
      List<LocationModel> matchingSubLocations = entity.subLocations
          .expand((subLocation) => _filterEntityBySearchTerm(subLocation, searchTerm))
          .cast<LocationModel>()
          .toList();

      List<AssetEntity> matchingAssets = entity.assets
          .expand((asset) => _filterEntityBySearchTerm(asset, searchTerm))
          .cast<AssetEntity>()
          .toList();

      // Mantém todos os filhos se o parent combinar com o termo de busca
      if (matches || matchingSubLocations.isNotEmpty || matchingAssets.isNotEmpty) {
        return [
          LocationModel(
            id: entity.id,
            name: entity.name,
            parentId: entity.parentId,
            subLocations: matches ? entity.subLocations : matchingSubLocations,
            assets: matches ? entity.assets : matchingAssets,
          )
        ];
      }
    } else if (entity is AssetModel) {
      List<AssetModel> matchingSubAssets = entity.subAssets
          .expand((subAsset) => _filterEntityBySearchTerm(subAsset, searchTerm))
          .cast<AssetModel>()
          .toList();

      List<ComponentModel> matchingComponents = entity.components
          .where((component) => component.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      // Mantém todos os filhos se o parent combinar com o termo de busca
      if (matches || matchingSubAssets.isNotEmpty || matchingComponents.isNotEmpty) {
        return [
          AssetModel(
            id: entity.id,
            name: entity.name,
            parentId: entity.parentId,
            locationId: entity.locationId,
            subAssets: matches ? entity.subAssets : matchingSubAssets,
            components: matches ? entity.components : matchingComponents,
          )
        ];
      }
    } else if (entity is ComponentModel) {
      if (matches) {
        return [entity];
      }
    }

    return <BaseEntity>[];
  }

  static List<BaseEntity> filterByEnergySensor(List<BaseEntity> entities) {
    return entities.expand((entity) {
      if (entity is ComponentModel && entity.sensorType == ComponentType.energy) {
        return [entity];
      } else if (entity is AssetModel) {
        var filteredSubAssets = filterByEnergySensor(entity.subAssets).cast<AssetModel>().toList();
        var filteredComponents = entity.components.where((component) => component.sensorType == ComponentType.energy).toList();

        if (filteredSubAssets.isNotEmpty || filteredComponents.isNotEmpty) {
          return [
            AssetModel(
              id: entity.id,
              name: entity.name,
              parentId: entity.parentId,
              locationId: entity.locationId,
              subAssets: filteredSubAssets,
              components: filteredComponents,
            )
          ];
        }
      } else if (entity is LocationModel) {
        var filteredSubLocations = filterByEnergySensor(entity.subLocations).cast<LocationModel>().toList();
        var filteredAssets = filterByEnergySensor(entity.assets).cast<AssetEntity>().toList();

        if (filteredSubLocations.isNotEmpty || filteredAssets.isNotEmpty) {
          return [
            LocationModel(
              id: entity.id,
              name: entity.name,
              parentId: entity.parentId,
              subLocations: filteredSubLocations,
              assets: filteredAssets,
            )
          ];
        }
      }
      return <BaseEntity>[];
    }).toList();
  }

  static List<BaseEntity> filterByCriticalStatus(List<BaseEntity> entities) {
    return entities.expand((entity) {
      if (entity is ComponentModel && entity.status == ComponentStatus.alert) {
        return [entity];
      } else if (entity is AssetModel) {
        var filteredSubAssets = filterByCriticalStatus(entity.subAssets).cast<AssetModel>().toList();
        var filteredComponents = entity.components.where((component) => component.status == ComponentStatus.alert).toList();

        if (filteredSubAssets.isNotEmpty || filteredComponents.isNotEmpty) {
          return [
            AssetModel(
              id: entity.id,
              name: entity.name,
              parentId: entity.parentId,
              locationId: entity.locationId,
              subAssets: filteredSubAssets,
              components: filteredComponents,
            )
          ];
        }
      } else if (entity is LocationModel) {
        var filteredSubLocations = filterByCriticalStatus(entity.subLocations).cast<LocationModel>().toList();
        var filteredAssets = filterByCriticalStatus(entity.assets).cast<AssetEntity>().toList();

        if (filteredSubLocations.isNotEmpty || filteredAssets.isNotEmpty) {
          return [
            LocationModel(
              id: entity.id,
              name: entity.name,
              parentId: entity.parentId,
              subLocations: filteredSubLocations,
              assets: filteredAssets,
            )
          ];
        }
      }
      return <BaseEntity>[];
    }).toList();
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
