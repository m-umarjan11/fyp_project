part of 'item_request_order_bloc.dart';

sealed class ItemRequestOrderState extends Equatable {
  const ItemRequestOrderState();
  
  @override
  List<Object> get props => [];
}

final class ItemRequestOrderInitial extends ItemRequestOrderState {}
final class ItemRequestOrderLoading extends ItemRequestOrderState {}
final class ItemRequestOrderSuccess extends ItemRequestOrderState {
  final List<Item> items;
  const ItemRequestOrderSuccess({required this.items});
  @override
  List<Object> get props => [items];
}
