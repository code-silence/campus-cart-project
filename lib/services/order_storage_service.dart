import 'package:hive/hive.dart';

class OrderStorageService {
  static const boxName = "orderBox";

  Future<void> saveOrders(List<Map> orders) async {
    final box = await Hive.openBox(boxName);
    await box.put("orders", orders);
  }

  Future<List<Map>> getOrders() async {
    final box = await Hive.openBox(boxName);
    return (box.get("orders", defaultValue: []) as List)
        .cast<Map>();
  }
}