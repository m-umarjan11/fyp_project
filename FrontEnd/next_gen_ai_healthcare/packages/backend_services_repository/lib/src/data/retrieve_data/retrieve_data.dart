import 'package:backend_services_repository/src/item/models/item.dart';
import 'package:backend_services_repository/src/result_wraper.dart';

abstract class RetrieveData {
  Future<Result<List<Item>, String>> getItemsNearMe({Map<String, dynamic> userLocation=const {}, int setNo=1}); //If Location is Turned off then grab random items
}