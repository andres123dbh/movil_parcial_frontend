import 'package:flutter/material.dart';

class ProductsApp extends StatefulWidget {
  const ProductsApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductsApp();
  }
}

class _ProductsApp extends State<ProductsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Products App'),
              backgroundColor: Colors.lightBlue,
            ),
            body: const Text("Testing")));
  }
}
