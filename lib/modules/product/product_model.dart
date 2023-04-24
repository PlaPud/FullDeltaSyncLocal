import 'package:hive/hive.dart';
import 'package:full_delta_sync/logging.dart';

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

  factory Product.fromJson(Map<String, dynamic> json, String typeOfSync) {
    var time = DateTime.now();
    final log = logger;
    double priceDatatypeChecked = -1;
    int remainInStockDatatypeChecked = -1;
    try {
      if (json['price'] is! double) {
        priceDatatypeChecked = json['price'].toDouble();
      } else {
        priceDatatypeChecked = json['price'];
      }

      if (json['remainInStock'] is! int) {
        remainInStockDatatypeChecked = json['remainInStock'].toInt();
      } else {
        remainInStockDatatypeChecked = json['remainInStock'];
      }
      Product product = Product(
        title: json['title'],
        aliasTitle: json['aliasTitle'],
        barcode: json['barcode'],
        sku: json['sku'],
        price: priceDatatypeChecked,
        remainInStock: remainInStockDatatypeChecked,
      );
      return product;
    } catch (_) {
      log.e("Error in $typeOfSync on Product'sku: ${json['sku']} at $time");
      rethrow;
    }
  }
}
