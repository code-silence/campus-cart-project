import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Order Summary",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text("Total: \$${order.total.toStringAsFixed(2)}"),
          Text("Items: ${order.items.length}"),
          Text("Date: ${order.date}"),

          const SizedBox(height: 20),

          const Text(
            "Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...order.items.map((item) {
            return ListTile(
              leading: Image.network(
                item.product.image,
                width: 50,
              ),
              title: Text(item.product.title),
              subtitle: Text(
                "\$${item.product.price}  x${item.quantity}",
              ),
            );
          }),
        ],
      ),
    );
  }
}