import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../utils/dummy_data.dart';

final productProvider = Provider<List<ProductModel>>((ref) {
  return dummyProducts;
});