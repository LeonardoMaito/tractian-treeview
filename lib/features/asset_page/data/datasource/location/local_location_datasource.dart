import 'package:treeview/features/asset_page/data/datasource/location/location_datasource.dart';
import 'package:treeview/features/asset_page/domain/models/location_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class LocalLocationDatasource extends LocationDataSource {
  final String path;

  LocalLocationDatasource(this.path);

  @override
  Future<List<LocationModel>> getLocations() async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => LocationModel.fromJson(item)).toList();
  }

}