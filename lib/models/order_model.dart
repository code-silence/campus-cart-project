import 'cart_item_model.dart';

class OrderModel {
  final List<CartItemModel> items;
  final double total;
  final DateTime date;

  OrderModel({
    required this.items,
    required this.total,
    required this.date,
  });
}