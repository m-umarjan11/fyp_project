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
    try {
      Uri url = Uri.parse("$api/items");
      print("Fetching items from $url");

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print("Parsed response: $responseBody");

        List<Item> items = (responseBody as List)
            .map((e) => Item.fromEntity(ItemEntity.fromJson(e)))
            .toList();
        return Result.success(items);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final error = json.decode(response.body)['message'] ?? "Failed to load data";
        return Result.failure(error);
      } else {
        return Result.failure("An unexpected error has occurred");
      }
    } catch (e) {
      print("Error occurred: $e");
      return Result.failure("An error occurred: $e");
    }
  }
}
