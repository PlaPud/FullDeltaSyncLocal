import 'package:flutter/material.dart';
import 'package:full_delta_sync/modules/product/product_model.dart';
import 'package:full_delta_sync/modules/product/product_view_model.dart';
import 'package:hive/hive.dart';

class ProductView extends StatefulWidget {
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<Product> productList = [];
  String inputText = '';
  ProductViewModel productViewModel = ProductViewModel();
  // delta sync need to use SKU as key (for fast access)
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30.0),
          child: TextField(
            controller: textEditingController,
            onChanged: (data) {
              setState(() {
                inputText = data;
              });
            },
            maxLines: 1,
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                productList = productViewModel.readData();
              });
            },
            child: Text(
              'Read JSON',
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await productViewModel.fullSyncWrite(inputText);
              setState(() {
                productList = productViewModel.readData();
                textEditingController.clear();
              });
            },
            child: Text(
              'Write JSON (Full Sync)',
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '{title: "${productList[index].title}", price: ${productList[index].price}, remainInStock: ${productList[index].remainInStock}',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
