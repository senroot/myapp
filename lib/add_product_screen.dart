import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/add_category_screen.dart';
import 'category_model.dart';
import 'product_model.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              hint: Text('Select Category'),
              value: selectedCategory,
              items:
                  categories.map<DropdownMenuItem<String>>((Category category) {
                return DropdownMenuItem<String>(
                  value: category.title,
                  child: Text(category.title),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final price = double.parse(_priceController.text);
                if (name.isNotEmpty && selectedCategory != null) {
                  final newProduct = Product(
                      name: name, price: price, category: selectedCategory!);
                  final productBox = Hive.box<Product>('products');
                  productBox.add(newProduct);
                  Navigator.pop(context);
                }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
