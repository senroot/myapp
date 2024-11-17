import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'category_model.dart';

class CategoryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryBox = Hive.box<Category>('categories');

    return ValueListenableBuilder(
      valueListenable: categoryBox.listenable(),
      builder: (context, Box<Category> box, _) {
        if (box.values.isEmpty) {
          return Center(child: Text('No categories available.'));
        }

        final categories = box.values.toList();
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category.title),
            );
          },
        );
      },
    );
  }
}
