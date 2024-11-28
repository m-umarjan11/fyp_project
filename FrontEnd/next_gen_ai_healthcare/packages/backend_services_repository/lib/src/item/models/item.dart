import 'package:backend_services_repository/src/item/entities/entities.dart';

class Item {
  final String itemId;
  final String itemName;
  final String description;
  final List<String> images;
  final Map<String, dynamic> location;

  Item(
      {required this.itemId,
      required this.itemName,
      required this.description,
      required this.images,
      required this.location});

  static ItemEntity toEntity(Item item) {
    return ItemEntity(
        itemId: item.itemId,
        itemName: item.itemName,
        description: item.description,
        images: item.images,
        location: item.location);
  }

  static Item fromEntity(ItemEntity itemEntity) {
    return Item(
        itemId: itemEntity.itemId,
        itemName: itemEntity.itemName,
        description: itemEntity.description,
        images: itemEntity.images,
        location: itemEntity.location);
  }
}
