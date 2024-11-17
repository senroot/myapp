import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String title;

  Category({required this.title});
}
