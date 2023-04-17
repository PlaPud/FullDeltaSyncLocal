import 'dart:convert';
import 'package:full_delta_sync/modules/product/product_model.dart';
import 'package:hive/hive.dart';

class ProductViewModel {
  List<Product> readData() {
    var productBox = Hive.box<Product>('products');
    List<Product> products = productBox.values.toList().cast<Product>();
    return products;
  }

  fullSyncWrite(String productListData) async {
    try {
      List<dynamic> decodedData = json.decode(productListData);
      List<Product> productList =
          decodedData.map((json) => Product.fromJson(json)).toList();
      var productBox = Hive.box<Product>('products');
      await productBox.clear();
      for (var product in productList) {
        productBox.put(product.sku, product);
      }
    } catch (e) {
      print(e);
    }
  }

  deltaSyncWrite(String productListData) async {
    try {
      List<dynamic> decodedData = json.decode(productListData);
      List<Product> productList = [];
      productList = decodedData.map((json) => Product.fromJson(json)).toList();
      var productBox = Hive.box<Product>('products');

      for (var product in productList) {
        productBox.put(product.sku, product);
      }
    } catch (e) {
      print(e);
    }
  }
}
