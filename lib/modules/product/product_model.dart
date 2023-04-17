import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String aliasTitle;

  @HiveField(2)
  late String barcode;

  @HiveField(3)
  late String sku;

  @HiveField(4)
  late double price;

  @HiveField(5)
  late int remainInStock;

  Product({
    required this.title,
    required this.aliasTitle,
    required this.barcode,
    required this.sku,
    required this.price,
    required this.remainInStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'].toString(),
      aliasTitle: json['aliasTitle'].toString(),
      barcode: json['barcode'].toString(),
      sku: json['sku'].toString(),
      price: double.parse(json['price'].toString()),
      remainInStock: int.parse(json['remainInStock'].toString()),
    );
  }
}
