import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../services/cart_storage_service.dart';
import '../utils/dummy_data.dart';

class CartNotifier extends Notifier<List<CartItemModel>> {
  final storage = CartStorageService();
  @override
  List<CartItemModel> build() {
    _loadCart();
    return [];
  }

  void addToCart(ProductModel product) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      state[index].quantity++;
      state = [...state];
    } else {
      state = [...state, CartItemModel(product: product)];
    }
    _saveCart();
  }

  void increaseQty(int productId) {
    state = state.map((item) {
      if (item.product.id == productId) {
        item.quantity++;
      }
      return item;
    }).toList();
    _saveCart();
  }

  void decreaseQty(int productId) {
    state = state.map((item) {
      if (item.product.id == productId && item.quantity > 1) {
        item.quantity--;
      }
      return item;
    }).toList();
    _saveCart();
  }

  Future<void> _loadCart() async {
    final savedIds = await storage.getCart();

    final loadedItems = savedIds.map((id) {
      final product = dummyProducts.firstWhere((p) => p.id == id);
      return CartItemModel(product: product);
    }).toList();

    state = loadedItems;
  }

  Future<void> _saveCart() async {
    final ids = state.map((e) => e.product.id).toList();
    await storage.saveCart(ids);
  }

  Future<void> clearCart() async {
    state = [];
    await storage.saveCart([]);
  }

  void removeItem(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
    _saveCart();
  }

  double get totalPrice {
    return state.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItemModel>>(
  CartNotifier.new,
);
