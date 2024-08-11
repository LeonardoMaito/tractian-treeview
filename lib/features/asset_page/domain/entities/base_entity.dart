abstract class BaseEntity {
  final String id;
  final String name;
  final String? parentId;

  BaseEntity({required this.id, required this.name, this.parentId});
}