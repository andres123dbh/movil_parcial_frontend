import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_parcial_frontend/favorites_list.dart';
import 'package:movil_parcial_frontend/list_products.dart';
/* import 'package:provider/provider.dart';
import 'favorites_changes_notification.dart'; */
//TODO delete all prints when all is ready
class ProductsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Products App'),
              backgroundColor: Colors.lightBlue,
            ),
            // TODO: This elevated buttonS are just temporary
            body: Column(
              children: [
                ElevatedButton(
                    onPressed: () => Get.to(const ProductList()),
                    child: Text("Go to ListProducts")),
                ElevatedButton(
                    onPressed: () => Get.to(const FavoritesList()),
                    child: Text("Go to FavProducts"))
              ],
            )));
  }
}
