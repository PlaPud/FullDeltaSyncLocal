import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  late final String title;

  @HiveField(1)
  late final String aliasTitle;

  @HiveField(2)
  late final String barcode;

  @HiveField(3)
  late final String sku;

  @HiveField(4)
  late final double price;

  @HiveField(5)
  late final int remainInStock;
}
