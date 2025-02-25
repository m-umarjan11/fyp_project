import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'item_request_order_event.dart';
part 'item_request_order_state.dart';

class ItemRequestOrderBloc extends Bloc<ItemRequestOrderEvent, ItemRequestOrderState> {
  final OrderAndPaymentImp orderAndPaymentImp;
  ItemRequestOrderBloc({required this.orderAndPaymentImp}) : super(ItemRequestOrderInitial()) {
    on<ItemOrderRequired>((event, emit) async{
      List<Item> items =await orderAndPaymentImp.getItemsUserOrdered(event.user);
      emit(ItemRequestOrderSuccess(items: items));
    });

    on<ItemRequestRequired>((event, emit) async{
      List<Item> items =await orderAndPaymentImp.getItemsUserOrdered(event.user);
      emit(ItemRequestOrderSuccess(items: items));
    });
  }
}
