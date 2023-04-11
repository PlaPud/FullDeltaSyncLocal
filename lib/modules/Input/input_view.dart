import 'package:flutter/material.dart';
import 'package:full_delta_sync/modules/Input/input_view_model.dart';
import 'package:full_delta_sync/modules/constants/temp.dart';

class InputView extends StatefulWidget {
  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  List<dynamic> productList = [];
  FileManager fileManager = FileManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () async {
              String path = await fileManager.directoryPath;
              print(path);
            },
            child: Text(
              'Get Directory Path',
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              dynamic json = await fileManager.readJsonFile();
              // print(json);
              setState(() {
                if (json != null) {
                  productList = json;
                }
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
              await fileManager.writeJsonFile(kJsonWriteMockData);
              dynamic json = await fileManager.readJsonFile();
              setState(() {
                if (json != null) {
                  productList = json;
                }
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
                  '(SKU ${productList[index]})',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
