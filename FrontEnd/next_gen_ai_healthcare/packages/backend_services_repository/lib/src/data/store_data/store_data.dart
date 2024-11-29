import 'package:backend_services_repository/src/item/models/models.dart';
import 'package:backend_services_repository/src/result_wraper.dart';

abstract class StoreData {
  Future<Result<String, String>> storeAnItem({required Item item}); 

}