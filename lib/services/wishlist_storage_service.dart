import 'package:hive/hive.dart';

class WishlistStorageService {
  static const String boxName = "wishlistBox";

  Future<void> saveWishlist(List<int> productIds) async {
    final box = await Hive.openBox(boxName);
    await box.put("items", productIds);
  }

  Future<List<int>> getWishlist() async {
    final box = await Hive.openBox(boxName);
    return (box.get("items", defaultValue: []) as List)
        .cast<int>();
  }
}