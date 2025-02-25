import 'package:backend_services_repository/backend_service_repositoy.dart';

abstract class OrderAndPayment {
  Future<Result<String, String>> paymentOperation(String selectedPaymentOption);
  Future<Result<String, String>> createOrder(Item orderedItem);
  Future<List<Item>> getItemsUserOrdered(User user);
  Future<List<Item>> getOrderRequest(User user);
}