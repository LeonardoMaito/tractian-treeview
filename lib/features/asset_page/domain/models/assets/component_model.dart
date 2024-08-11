import 'package:treeview/features/asset_page/domain/entities/asset_entity.dart';

class ComponentModel extends AssetEntity {
  final ComponentStatus status;
  final ComponentType sensorType;

  ComponentModel({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    required this.sensorType,
    required this.status,
  });

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: ComponentType.values.firstWhere(
            (e) => e.type == json['sensorType'],
        orElse: () => throw ArgumentError('Invalid sensorType'),
      ),
      status: ComponentStatus.values.firstWhere(
            (e) => e.status == json['status'],
        orElse: () => throw ArgumentError('Invalid status'),
      ),
    );
  }
}

enum ComponentStatus {
  operating('operating'),
  alert('alert');

  final String status;
  const ComponentStatus(this.status);
}

enum ComponentType {
  energy('energy'),
  vibration('vibration');

  final String type;
  const ComponentType(this.type);
}