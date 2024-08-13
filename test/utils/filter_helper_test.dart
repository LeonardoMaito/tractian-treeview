import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/domain/models/assets/asset_model.dart';
import 'package:treeview/features/asset_page/domain/models/assets/component_model.dart';
import 'package:treeview/features/asset_page/domain/models/location/location_model.dart';
import 'package:treeview/features/utils/filter_helper.dart';

void main() {
  group('FilterHelper', () {
    test('should filter and include only energy sensors within LocationModel', () {
      var energyComponent = ComponentModel(
        id: '1',
        name: 'Energy Sensor',
        sensorType: ComponentType.energy,
        status: ComponentStatus.operating,
      );

      var vibrationComponent = ComponentModel(
        id: '2',
        name: 'Vibration Sensor',
        sensorType: ComponentType.vibration,
        status: ComponentStatus.operating,
      );

      var asset = AssetModel(
        id: '3',
        name: 'Asset with Sensors',
        subAssets: [],
        components: [energyComponent, vibrationComponent],
      );

      var location = LocationModel(
        id: '4',
        name: 'Location',
        subLocations: [],
        assets: [asset],
      );

      var filteredEntities = FilterHelper.filterByEnergySensor([location]);

      expect(filteredEntities.length, 1);
      expect(filteredEntities.first is LocationModel, isTrue);

      var filteredLocation = filteredEntities.first as LocationModel;

      expect(filteredLocation.assets.length, 1);
      expect(filteredLocation.assets.first is AssetModel, isTrue);

      var filteredAsset = filteredLocation.assets.first as AssetModel;

      expect(filteredAsset.components.length, 1);
      expect(filteredAsset.components.first.sensorType, ComponentType.energy);
    });

    test('should filter and include only critical status components within LocationModel', () {
      var criticalComponent = ComponentModel(
        id: '1',
        name: 'Critical Sensor',
        sensorType: ComponentType.energy,
        status: ComponentStatus.alert,
      );

      var normalComponent = ComponentModel(
        id: '2',
        name: 'Normal Sensor',
        sensorType: ComponentType.vibration,
        status: ComponentStatus.operating,
      );

      var asset = AssetModel(
        id: '3',
        name: 'Asset with Sensors',
        subAssets: [],
        components: [criticalComponent, normalComponent],
      );

      var location = LocationModel(
        id: '4',
        name: 'Location',
        subLocations: [],
        assets: [asset],
      );

      var filteredEntities = FilterHelper.filterByCriticalStatus([location]);

      expect(filteredEntities.length, 1);
      expect(filteredEntities.first is LocationModel, isTrue);

      var filteredLocation = filteredEntities.first as LocationModel;

      expect(filteredLocation.assets.length, 1);
      expect(filteredLocation.assets.first is AssetModel, isTrue);

      var filteredAsset = filteredLocation.assets.first as AssetModel;

      expect(filteredAsset.components.length, 1);
      expect(filteredAsset.components.first.status, ComponentStatus.alert);
    });

    test('should return empty list if no energy sensors exist in LocationModel', () {
      var vibrationComponent = ComponentModel(
        id: '1',
        name: 'Vibration Sensor',
        sensorType: ComponentType.vibration,
        status: ComponentStatus.operating,
      );

      var asset = AssetModel(
        id: '2',
        name: 'Asset with Sensors',
        subAssets: [],
        components: [vibrationComponent],
      );

      var location = LocationModel(
        id: '3',
        name: 'Location',
        subLocations: [],
        assets: [asset],
      );

      var filteredEntities = FilterHelper.filterByEnergySensor([location]);

      expect(filteredEntities.isEmpty, isTrue);
    });

    test('should return empty list if no critical status components exist in LocationModel', () {
      var normalComponent = ComponentModel(
        id: '1',
        name: 'Normal Sensor',
        sensorType: ComponentType.vibration,
        status: ComponentStatus.operating,
      );

      var asset = AssetModel(
        id: '2',
        name: 'Asset with Sensors',
        subAssets: [],
        components: [normalComponent],
      );

      var location = LocationModel(
        id: '3',
        name: 'Location',
        subLocations: [],
        assets: [asset],
      );

      var filteredEntities = FilterHelper.filterByCriticalStatus([location]);

      expect(filteredEntities.isEmpty, isTrue);
    });
  });
}
