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
}