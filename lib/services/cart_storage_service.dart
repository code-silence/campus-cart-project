import 'package:hive/hive.dart';

class CartStorageService {
  static const boxName = "cartBox";

  Future<void> saveCart(List<int> productIds) async {
    final box = await Hive.openBox(boxName);
    await box.put("items", productIds);
  }

  Future<List<int>> getCart() async {
    final box = await Hive.openBox(boxName);
    return (box.get("items", defaultValue: []) as List)
        .cast<int>();
  }
}