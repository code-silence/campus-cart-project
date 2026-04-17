import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get(
      'https://fakestoreapi.com/products',
    );

    return (response.data as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
  }
}