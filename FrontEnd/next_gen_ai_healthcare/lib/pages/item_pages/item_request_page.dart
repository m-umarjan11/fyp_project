import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/item_request_order_bloc/item_request_order_bloc.dart';

class ItemRequestPage extends StatefulWidget {
  final User user;
  const ItemRequestPage({super.key, required this.user});

  @override
  State<ItemRequestPage> createState() => _ItemRequestPageState();
}

class _ItemRequestPageState extends State<ItemRequestPage> {
  List<Item>? items;
  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    items = await BlocProvider.of<ItemRequestOrderBloc>(context)
        .orderAndPaymentImp
        .getOrderRequest(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your requests"),
      ),
      body: items != null 
          ? ListView.builder(
              itemBuilder: (context, index) => ListTile(
                    leading: Image(image: NetworkImage(items![index].images[0])),
                    title: Text(items![index].itemName),
                    subtitle: Text(items![index].description),
                    trailing: Text("RS ${items![index].price}"),
                  ), )
          : const Center(
              child: Text("No requests found"),
            ),
    );
  }
}
