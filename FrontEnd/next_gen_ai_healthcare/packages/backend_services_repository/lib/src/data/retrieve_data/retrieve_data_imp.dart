import 'dart:convert';
import 'dart:io';

import 'package:backend_services_repository/src/data/api.dart';
import 'package:backend_services_repository/src/data/retrieve_data/retrieve_data.dart';
import 'package:backend_services_repository/src/item/entities/entities.dart';
import 'package:backend_services_repository/src/item/models/item.dart';
import 'package:backend_services_repository/src/result_wraper.dart';


class RetrieveDataImp extends RetrieveData{
  HttpClient http = HttpClient();

  @override
  Future<Result<List<Item>, String>> getItemsNearMe({Map<String, dynamic> userLocation = const {}, int setNo = 1}) async{
    Uri url = Uri.parse("$api/items");
    HttpClientRequest request = await http.getUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write({'location':userLocation, 'setNo':1});
    HttpClientResponse response = await request.close();
    if(response.statusCode==200){
      String responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> responseJson = json.decode(responseBody);
      List<Item> items = responseJson['items'].map((e)=>Item.fromEntity(ItemEntity.fromJson(e)));
      return Result.success(items);
    } else if(response.statusCode>=400 && response.statusCode<500){
      return Result.failure("Failed to load data");
    } else{
      return Result.failure("An unexpected error has occurred");
    }
  }
}