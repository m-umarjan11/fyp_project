import 'dart:convert';
import 'dart:io';

import 'package:backend_services_repository/src/data/api.dart';
import 'package:backend_services_repository/src/data/store_data/sql_helper.dart';
import 'package:backend_services_repository/src/data/store_data/store_data.dart';
import 'package:backend_services_repository/src/item/entities/entities.dart';
import 'package:backend_services_repository/src/item/models/item.dart';
import 'package:backend_services_repository/src/result_wraper.dart';
import 'package:backend_services_repository/src/user/entities/entities.dart';
import 'package:backend_services_repository/src/user/models/user.dart';

class StoreDataImp extends StoreData {
  HttpClient http = HttpClient();
 

  @override
  Future<Result<String, String>> storeAnItem({required Item item}) async{
    Uri url = Uri.parse("$api/items");
    HttpClientRequest request = await http.postUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.write(ItemEntity.toJson(Item.toEntity(item)));
    HttpClientResponse response =await request.close();
    if(response.statusCode==201){
      String responseBody = await response.transform(utf8.decoder).join();
      return Result.success(json.decode(responseBody)['status']);
    }else if(response.statusCode>=400 && response.statusCode<500){
      String responseBody = await response.transform(utf8.decoder).join();
      return Result.failure(json.decode(responseBody)['status']);
    }else{
      return Result.failure("An unexpected error occurred");
    }
  }

  
}
