import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_screen.dart';
import 'category_model.dart';
import 'product_model.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  final box = Hive.box<Category>('categories');
  return CategoryNotifier(box.values.toList());
});

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Category>('categories');
  await Hive.openBox<Product>('products');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier(List<Category> initialCategories) : super(initialCategories);

  void addCategory(Category category) {
    final box = Hive.box<Category>('categories');
    box.add(category);
    state = box.values.toList();
  }
}
