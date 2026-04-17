import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';
import '../services/order_storage_service.dart';
import '../utils/dummy_data.dart';

class OrderNotifier extends Notifier<List<OrderModel>> {
  final storage = OrderStorageService();

  @override
  List<OrderModel> build() {
    _loadOrders();
    return [];
  }

  Future<void> _loadOrders() async {
  final data = await storage.getOrders();

  final orders = data.map((orderMap) {
    final items = (orderMap['items'] as List).map((item) {
      final product = dummyProducts.firstWhere(
        (p) => p.id == item['productId'],
      );

      return CartItemModel(
        product: product,
        quantity: item['quantity'],
      );
    }).toList();

    return OrderModel(
      items: items,
      total: orderMap['total'],
      date: DateTime.parse(orderMap['date']),
    );
  }).toList();

  state = orders;
}

  Future<void> _saveOrders() async {
  final data = state.map((order) {
    return {
      'items': order.items
          .map((item) => {
                'productId': item.product.id,
                'quantity': item.quantity,
              })
          .toList(),
      'total': order.total,
      'date': order.date.toIso8601String(),
    };
  }).toList();

  await storage.saveOrders(data);
}

  void placeOrder(List<CartItemModel> cartItems, double total) {
    final newOrder = OrderModel(
      items: cartItems,
      total: total,
      date: DateTime.now(),
    );

    state = [newOrder, ...state];
    _saveOrders();
  }
}

final orderProvider =
    NotifierProvider<OrderNotifier, List<OrderModel>>(
  OrderNotifier.new,
);