import 'dart:convert';
import 'package:full_delta_sync/modules/product/product_model.dart';
import 'package:hive/hive.dart';

class ProductViewModel {
  List<Product> productList = [];
  List<Product> onUserTappedReadData() {
    var productBox = Hive.box<Product>('products');
    productList = productBox.values.toList().cast<Product>();
    return productList;
  }

  Future<void> onUserTappedDeltaSync({required String productListData}) async {
    List<dynamic> decodedData = json.decode(productListData);
    var productBox = Hive.box<Product>('products');
    for (dynamic product in decodedData) {
      try {
        Product temp =
            Product.fromJson(json: product, typeOfSync: "Delta Sync");
        productBox.put(temp.sku, temp);
      } catch (_) {}
    }
    productList = onUserTappedReadData();
  }

  Future<void> onUserTappedFullSync({required String productListData}) async {
    List<dynamic> decodedData = json.decode(productListData);
    var productBox = Hive.box<Product>('products');
    await productBox.clear();
    for (dynamic product in decodedData) {
      try {
        Product temp = Product.fromJson(json: product, typeOfSync: "Full Sync");
        productBox.put(temp.sku, temp);
      } catch (_) {}
    }
    productList = onUserTappedReadData();
  }
}
