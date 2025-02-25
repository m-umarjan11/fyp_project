import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:flutter/material.dart';

class ItemPaymentPage extends StatefulWidget {
  final Item item;

  const ItemPaymentPage({super.key, required this.item});

  @override
  State<ItemPaymentPage> createState() => _ItemPaymentPageState();
}

class _ItemPaymentPageState extends State<ItemPaymentPage> {
  @override
  Widget build(BuildContext context) {
    String selectedPaymentOption = "Cash on delivery";
    return Scaffold(
      appBar: AppBar(title: Text("Payment for ${widget.item.itemName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Choose Payment Method:",
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            RadioListTile(
                title: const Text("Cash on delivery"),
                secondary: const Icon(Icons.handshake),
                value: "Cash on delivery",
                groupValue: selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                }),
            RadioListTile(
                secondary: const Icon(Icons.credit_card),
                value: "Card",
                groupValue: selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                }),
            RadioListTile(
                secondary: const Icon(Icons.monetization_on),
                value: "Easypaisa",
                groupValue: selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                }),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  //TODO: Payment Gateway connection here please
                },
                child: const Text("Proceed")),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
