import 'dart:convert';

import 'package:backend_services_repository/src/data/api.dart';
import 'package:backend_services_repository/src/data/store_data/store_data.dart';
import 'package:backend_services_repository/src/item/entities/entities.dart';
import 'package:backend_services_repository/src/item/models/item.dart';
import 'package:backend_services_repository/src/result_wraper.dart';
import 'package:http/http.dart' as http;

class StoreDataImp extends StoreData {
  @override
  Future<Result<String, String>> storeAnItem({required Item item}) async {
    Uri url = Uri.parse("$api/items");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ItemEntity.toJson(Item.toEntity(item))),
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      return Result.success(responseBody['status']);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final responseBody = json.decode(response.body);
      return Result.failure(responseBody['status']);
    } else {
      return Result.failure("An unexpected error occurred");
    }
  }
}
