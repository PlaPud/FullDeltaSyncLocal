import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:full_delta_sync/button.dart';
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
          padding: const EdgeInsets.all(30.0),
          child: TextField(
            decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Put your JSON data here..",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            controller: textEditingController,
            onChanged: (data) {
              setState(() {
                inputText = data;
              });
            },
            maxLines: 7,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                productList = productViewModel.readData();
              });
            },
            style: ButtonStyle(
              foregroundColor: getColor(Colors.white, Colors.teal),
              backgroundColor: getColor(Colors.teal, Colors.white),
            ),
            child: const Text(
              'Read JSON',
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(Colors.white, Colors.teal),
              backgroundColor: getColor(Colors.teal, Colors.white),
            ),
            onPressed: () async {
              await productViewModel.fullSyncWrite(inputText);
              setState(() {
                productList = productViewModel.readData();
                textEditingController.clear();
              });
            },
            child: const Text(
              'Write (Full)',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await productViewModel.deltaSyncWrite(inputText);
              setState(() {
                productList = productViewModel.readData();
                // textEditingController.clear();
              });
            },
            style: ButtonStyle(
              foregroundColor: getColor(Colors.white, Colors.teal),
              backgroundColor: getColor(Colors.teal, Colors.white),
            ),
            child: const Text(
              'Write (Delta)',
            ),
          )
        ]),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '{title: "${productList[index].title}", price: ${productList[index].price}, remainInStock: ${productList[index].remainInStock}}',
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    getColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    }

    return MaterialStateProperty.resolveWith(getColor);
  }
}
