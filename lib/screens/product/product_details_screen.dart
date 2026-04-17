import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final wishlistItems = ref.watch(wishlistProvider);

              final isWishlisted = wishlistItems.any(
                (item) => item.id == product.id,
              );

              return IconButton(
                onPressed: () {
                  ref.read(wishlistProvider.notifier).toggleWishlist(product);
                },
                icon: Icon(
                  isWishlisted ? Icons.favorite : Icons.favorite_border,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 260,
                      child: Image.network(product.image, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("⭐ ${product.rating}"),
                    const SizedBox(height: 16),
                    Text(product.description, textAlign: TextAlign.center),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // 🛒 sticky bottom button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to cart")),
                    );
                  },
                  child: const Text("Add to Cart"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
