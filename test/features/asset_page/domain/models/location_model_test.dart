import 'package:flutter_test/flutter_test.dart';
import 'package:treeview/features/asset_page/domain/models/location_model.dart';

void main() {
  test('Create LocationModel from JSON', (){
    final jaguarLocationJson = {
      "name": "CHARCOAL STORAGE SECTOR",
      "id": "656a07b3f2d4a1001e2144bf",
      "parentId": "65674204664c41001e91ecb4"
    };

    final jaguarLocation = LocationModel.fromJson(jaguarLocationJson);

    expect(jaguarLocation.id, '656a07b3f2d4a1001e2144bf');
    expect(jaguarLocation.name, 'CHARCOAL STORAGE SECTOR');
    expect(jaguarLocation.parentId, '65674204664c41001e91ecb4');
    expect(jaguarLocation, isA<LocationModel>());
  });

  test('Create LocationModel subLocation from JSON', (){

    final jaguarLocationJson = {
      "name": "PRODUCTION AREA - RAW MATERIAL",
      "id": "65674204664c41001e91ecb4",
      "parentId": null

    };

    final jaguarLocationTwoJson = {
      "name": "CHARCOAL STORAGE SECTOR",
      "id": "656a07b3f2d4a1001e2144bf",
      "parentId": "65674204664c41001e91ecb4"
    };


    final jaguarLocation = LocationModel.fromJson(jaguarLocationJson);
    final jaguarLocationTwo = LocationModel.fromJson(jaguarLocationTwoJson);

    if(jaguarLocationTwo.parentId == jaguarLocation.id){
      final newSubLocationList = List<LocationModel>.from(jaguarLocation.subLocations)
        ..add(jaguarLocationTwo);
      final updatedJaguarAsset = jaguarLocation.copyWith(subLocations: newSubLocationList);
      expect(updatedJaguarAsset.subLocations.length, 1);
      expect(updatedJaguarAsset.subLocations.first.id, jaguarLocationTwo.id);
    }
  });
}