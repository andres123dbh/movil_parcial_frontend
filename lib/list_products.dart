import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_card.dart';
import 'package:provider/provider.dart';
import 'package:movil_parcial_frontend/favorites_changes_notification.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductList();
  }
}

class _ProductList extends State<ProductList> {
  Map data = {};
  List productsData = [];
  // TODO put real request from database - delete this when is ready
  String sUrl = "https://api.npoint.io/d9b1898b87db7dc7a8f2";

  Future getProducts() async {
    try {
      http.Response response = await http.get(Uri.parse(sUrl));
      data = jsonDecode(response.body);
      if (data['message'] == 'ok') {
        setState(() {
          productsData = data['products'];
        });
      }
    } catch (e) {
      return Error();
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Products List'),
            ),
            // TODO make change of status between 2 type of views - delete this when is ready
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.change_circle,
                      size: 40,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 0),
                        child: ListView.builder(
                            itemCount: productsData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                  index,
                                  "${productsData[index]['title']}",
                                  "${productsData[index]['seller']}",
                                  double.parse(
                                      "${productsData[index]['rating']}"),
                                  "${productsData[index]['image']}",
                                  false);
                            })))
              ],
            )));
  }
}
