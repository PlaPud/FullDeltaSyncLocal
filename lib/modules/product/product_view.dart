import 'package:flutter/material.dart';
import 'package:full_delta_sync/modules/product/product_view_model.dart';
import 'package:hive/hive.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String inputText = '';
  final ProductViewModel _viewModel = ProductViewModel();
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
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 14),
          child: TextField(
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Put your JSON data here..",
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            controller: textEditingController,
            onChanged: (data) {
              setState(() {
                inputText = data;
              });
            },
            maxLines: 7,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(18, 0, 20, 0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              style: ButtonStyle(
                foregroundColor: getColor(Colors.white, Colors.redAccent),
                backgroundColor: getColor(Colors.red, Colors.white),
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
                await _viewModel.onUserTappedFullSync(
                    productListData: inputText);
                setState(() {
                  textEditingController.clear();
                });
              },
              child: const Text(
                'Write (Full)',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _viewModel.onUserTappedDeltaSync(
                    productListData: inputText);
                setState(() {
                  textEditingController.clear();
                });
              },
              style: ButtonStyle(
                foregroundColor: getColor(Colors.white, Colors.blue),
                backgroundColor: getColor(Colors.blue, Colors.white),
              ),
              child: const Text(
                'Write (Delta)',
              ),
            )
          ]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 14, 30, 20),
            child: Container(
              decoration: const BoxDecoration(),
              child: ListView.builder(
                itemCount: (_viewModel.productList).length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Title: ${_viewModel.onUserTappedReadData()[index].title}',
                      ),
                      subtitle: Text(
                          'Price: ${_viewModel.onUserTappedReadData()[index].price} Baht'),
                      trailing: Text(
                          'Stock(s): ${_viewModel.onUserTappedReadData()[index].remainInStock}'),
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
