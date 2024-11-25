import 'dart:convert';

class ItemEntity {
  final String itemId;
  final String itemName;
  final String description;
  final List<String> images;
  final Map<String, dynamic> location;

  ItemEntity(
      {required this.itemId,
      required this.itemName,
      required this.description,
      required this.images,
      required this.location});

  

  ItemEntity fromJson(String jsonString) {
    Map<String, dynamic> jsonObject = json.decode(jsonString);
    return ItemEntity(
      itemId: jsonObject['itemId'],
      itemName: jsonObject['itemName'],
      description: jsonObject['description'],
      images: jsonObject['images'],
      location: jsonObject['location'],
    );
  }

  Map<String, dynamic> toJson(ItemEntity itemEntity) {
    return {
      'itemId': itemEntity.itemId,
      'itemName': itemEntity.itemName,
      'description': itemEntity.description,
      'images': itemEntity.images,
      'location': itemEntity.location,
    };
  }
}
