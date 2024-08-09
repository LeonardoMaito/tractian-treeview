import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/models/asset_model.dart';
import '../../../domain/models/component_model.dart';
import '../../../domain/models/i_asset.dart';
import 'asset_datasource.dart';

class LocalAssetDataSource implements AssetDataSource {
  final String path;

  LocalAssetDataSource(this.path);

  @override
  Future<List<IAsset>> getAssets() async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map<IAsset>((item) {
      if (item['sensorType'] != null) {
        return ComponentModel.fromJson(item);
      } else {
        return AssetModel.fromJson(item);
      }
    }).toList();
  }
}