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

  

  static ItemEntity fromJson(Map<String, dynamic> jsonObject) {
    return ItemEntity(
      itemId: jsonObject['itemId'],
      itemName: jsonObject['itemName'],
      description: jsonObject['description'],
      images: jsonObject['images'],
      location: jsonObject['location'],
    );
  }

  static Map<String, dynamic> toJson(ItemEntity itemEntity) {
    return {
      'itemId': itemEntity.itemId,
      'itemName': itemEntity.itemName,
      'description': itemEntity.description,
      'images': itemEntity.images,
      'location': itemEntity.location,
    };
  }
}
