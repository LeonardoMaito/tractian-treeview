
import 'i_asset.dart';

class ComponentModel implements IAsset {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? locationId;

  @override
  final String? parentId;

  final String status;
  final String sensorType;

  ComponentModel({
    required this.id,
    required this.name,
    required this.sensorType,
    this.locationId,
    this.parentId,
    required this.status,
  });

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'],
      name: json['name'],
      sensorType: json['sensorType'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      status: json['status'],
    );
  }
}