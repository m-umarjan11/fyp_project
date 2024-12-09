import 'dart:convert';

import 'package:backend_services_repository/src/data/api.dart';
import 'package:backend_services_repository/src/data/retrieve_data/retrieve_data.dart';
import 'package:backend_services_repository/src/item/entities/entities.dart';
import 'package:backend_services_repository/src/item/models/item.dart';
import 'package:backend_services_repository/src/result_wraper.dart';
import 'package:http/http.dart' as http;

class RetrieveDataImp extends RetrieveData {
  @override
  Future<Result<List<Item>, String>> getItemsNearMe({Map<String, dynamic> userLocation = const {}, int setNo = 1}) async {
    Uri url = Uri.parse("$api/items?setNo=$setNo&location=${json.encode(userLocation)}");

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<Item> items = (responseBody['items'] as List)
          .map((e) => Item.fromEntity(ItemEntity.fromJson(e)))
          .toList();
      return Result.success(items);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Result.failure("Failed to load data");
    } else {
      return Result.failure("An unexpected error has occurred");
    }
  }
}
