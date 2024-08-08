
class ComponentModel {
  final String id;
  final String name;
  final String sensorType;
  final String? locationId;
  final String? parentId;
  final String status;

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