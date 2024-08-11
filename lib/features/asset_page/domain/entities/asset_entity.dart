import 'package:treeview/features/asset_page/domain/entities/base_entity.dart';

abstract class AssetEntity extends BaseEntity{
  final String? locationId;
  AssetEntity({required super.id, required super.name, super.parentId, this.locationId});

}