import 'package:flutter/material.dart';
import 'package:full_delta_sync/constants/button.dart';
import 'package:full_delta_sync/modules/product/product_model.dart';
import 'package:full_delta_sync/modules/product/product_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('products');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: buttonStyleCustom)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink,
        title: const Text('Test For Writing File (JSON)'),
      ),
      body: ProductView(),
    );
  }
}
