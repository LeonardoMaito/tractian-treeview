import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/domain/models/asset_model.dart';

void main() {
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

    test('Create AssetModel subAsset from JSON', (){

      final jaguarAssetJson = {
        "name": "CONVEYOR BELT ASSEMBLY",
        "id": "656a07bbf2d4a1001e2144c2",
        "locationId": "656a07b3f2d4a1001e2144bf",
        "parentId": null,
        "sensorType": null,
        "status": null
      };

      final jaguarAssetTwoJson = {
          "name": "MOTOR TC01 COAL UNLOADING AF02",
          "id": "656a07c3f2d4a1001e2144c5",
          "locationId": null,
          "parentId": "656a07bbf2d4a1001e2144c2",
          "sensorType": null,
          "status": null
        };


      final jaguarAsset = AssetModel.fromJson(jaguarAssetJson);
      final jaguarAssetTwo = AssetModel.fromJson(jaguarAssetTwoJson);

      if(jaguarAssetTwo.parentId == jaguarAsset.id){
        final newSubAssetList = List<AssetModel>.from(jaguarAsset.subAssets)
          ..add(jaguarAssetTwo);
        final updatedJaguarAsset = jaguarAsset.copyWith(subAssets: newSubAssetList);
        expect(updatedJaguarAsset.subAssets.length, 1);
        expect(updatedJaguarAsset.subAssets.first.id, jaguarAssetTwo.id);
      }
    });
}