import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services/wishlist_storage_service.dart';
import '../utils/dummy_data.dart';

class WishlistNotifier extends Notifier<List<ProductModel>> {
  final storage = WishlistStorageService();
  @override
  List<ProductModel> build() {
    _loadWishlist();
    return [];
  }

  Future<void> _loadWishlist() async {
    final savedIds = await storage.getWishlist();

    final items = savedIds.map((id) {
      return dummyProducts.firstWhere((p) => p.id == id);
    }).toList();

    state = items;
  }

  Future<void> _saveWishlist() async {
    final ids = state.map((e) => e.id).toList();
    await storage.saveWishlist(ids);
  }

  void toggleWishlist(ProductModel product) {
    final exists = state.any((item) => item.id == product.id);

    if (exists) {
      state = state.where((item) => item.id != product.id).toList();
    } else {
      state = [...state, product];
    }

    _saveWishlist();
  }

  bool isWishlisted(ProductModel product) {
    return state.any((item) => item.id == product.id);
  }
}

final wishlistProvider = NotifierProvider<WishlistNotifier, List<ProductModel>>(
  WishlistNotifier.new,
);
