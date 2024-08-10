import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/domain/models/component_model.dart';

void main() {
  test('Create ComponentModel from JSON', (){
    final jaguarAssetJson = {
      "name": "MOTOR RT COAL AF01",
      "id": "656a07cdc50ec9001e84167b",
      "locationId": null,
      "parentId": "656a07c3f2d4a1001e2144c5",
      "sensorType": "vibration",
      "status": "operating"
    };

    final jaguarComponent = ComponentModel.fromJson(jaguarAssetJson);

    expect(jaguarComponent.id, '656a07cdc50ec9001e84167b');
    expect(jaguarComponent.name, 'MOTOR RT COAL AF01');
    expect(jaguarComponent.locationId, null);
    expect(jaguarComponent.sensorType, 'vibration');
    expect(jaguarComponent.status, 'operating');
    expect(jaguarComponent, isA<ComponentModel>());
  });
}