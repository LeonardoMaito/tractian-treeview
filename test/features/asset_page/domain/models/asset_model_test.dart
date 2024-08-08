import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/domain/models/asset_model.dart';

void main() {
  group('AssetModel Tests', () {
    test('Create AssetModel from JSON', (){
      final jaguarAssetJson = {
        "name": "CONVEYOR BELT ASSEMBLY",
        "id": "656a07bbf2d4a1001e2144c2",
        "locationId": "656a07b3f2d4a1001e2144bf",
        "parentId": null,
        "sensorType": null,
        "status": null
      };

      final jaguarAsset = AssetModel.fromJson(jaguarAssetJson);

      expect(jaguarAsset.id, '656a07bbf2d4a1001e2144c2');
      expect(jaguarAsset.name, 'CONVEYOR BELT ASSEMBLY');
      expect(jaguarAsset.locationId, '656a07b3f2d4a1001e2144bf');
    });
  });
}