import 'dart:convert';

import 'package:full_delta_sync/modules/product/product_model.dart';
import 'package:hive/hive.dart';

class ProductViewModel {
  List<Product> _parseToHiveObject(List<dynamic> decodedData) {
    return decodedData.map((product) {
      var hiveObject = Product();

      hiveObject.title = product['title'];
      hiveObject.aliasTitle = product['aliasTitle'];
      hiveObject.barcode = product['barcode'];
      hiveObject.sku = product['sku'];
      hiveObject.price = product['price'];
      hiveObject.remainInStock = product['remainInStock'];

      return hiveObject;
    }).toList();
  }

  List<Product> readData() {
    var productBox = Hive.box<Product>('products');
    List<Product> products = productBox.values.toList().cast<Product>();
    return products;
  }

  fullSyncWrite(String productListData) async {
    List<dynamic> decodedData = json.decode(productListData);
    List<Product> productList = _parseToHiveObject(decodedData);

    var productBox = Hive.box<Product>('products');
    await productBox.clear();
    try {
      for (var product in productList) {
        productBox.put(product.sku, product);
      }
      print('Write Complete!');
    } catch (e) {
      print(e);
    }
  }
}
