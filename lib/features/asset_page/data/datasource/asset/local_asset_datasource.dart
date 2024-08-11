import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';
import '../../../domain/models/assets/asset_model.dart';
import '../../../domain/models/assets/component_model.dart';
import 'asset_datasource.dart';

class LocalAssetDataSource implements AssetDataSource {
  final String path;

  LocalAssetDataSource(this.path);

  @override
  Future<List<AssetEntity>> getAssets() async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map<AssetEntity>((item) {
      if (item['sensorType'] != null) {
        return ComponentModel.fromJson(item);
      } else {
        return AssetModel.fromJson(item);
      }
    }).toList();
  }
}