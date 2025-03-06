import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_ai_healthcare/pages/item_pages/item_payment_page.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.itemName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: item.images.length,
                itemBuilder: (context, index) {
                  return Image.network(item.images[index], fit: BoxFit.cover);
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(item.itemName, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text("Seller: ${item.seller}", style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(item.rating.toString()),
              ],
            ),
            const SizedBox(height: 8),
            Text(item.description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Text(
              item.sold > 0 ? "Sold Out" : "Available",
              style: TextStyle(
                color: item.sold > 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: item.sold > 0
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemPaymentPage(item: item)),
                  );
                },
          child: const Text("Proceed to Payment"),
        ),
      ),
    );
  }
}
