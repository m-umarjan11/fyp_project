import 'package:backend_services_repository/src/item/entities/entities.dart';

class Item {
  final String itemId;
  final String itemName;
  final String description;
  final List<String> images;
  final Map<String, dynamic> location;
  final String seller; 
  final int sold;      
  final double rating; 

  Item({
    required this.itemId,
    required this.itemName,
    required this.description,
    required this.images,
    required this.location,
    required this.seller,
    required this.sold,
    required this.rating,
  });

  static ItemEntity toEntity(Item item) {
    return ItemEntity(
      itemId: item.itemId,
      itemName: item.itemName,
      description: item.description,
      images: item.images,
      location: item.location,
      seller: item.seller,
      sold: item.sold,     
      rating: item.rating, 
    );
  }

  static Item fromEntity(ItemEntity itemEntity) {
    return Item(
      itemId: itemEntity.itemId,
      itemName: itemEntity.itemName,
      description: itemEntity.description,
      images: itemEntity.images,
      location: itemEntity.location,
      seller: itemEntity.seller,
      sold: itemEntity.sold,     
      rating: itemEntity.rating, 
    );
  }
}
