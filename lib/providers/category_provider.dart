import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends Notifier<String> {
  @override
  String build() => "All";

  void changeCategory(String category) {
    state = category;
  }
}

final selectedCategoryProvider =
    NotifierProvider<CategoryNotifier, String>(
  CategoryNotifier.new,
);