import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_parcial_frontend/favs_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './login/login.dart';
import 'package:movil_parcial_frontend/favorites_list.dart';
import 'package:movil_parcial_frontend/list_products.dart';

class ProductsApp extends StatelessWidget {
  const ProductsApp({super.key});

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FavoritesDatabase.instance.deleteAll();
    prefs.remove("accessToken");
    Get.to(() => const Login());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Menu'),
              backgroundColor: Colors.lightBlue,
            ),
            body: Center(
                child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => Get.to(() => const ProductList()),
                    child: const Text("All Products")),
                ElevatedButton(
                    onPressed: () => Get.to(() => const FavoritesList()),
                    child: const Text("Favorite Products")),
                ElevatedButton(
                    onPressed: () {
                      removeValues();
                    },
                    child: const Text("Log Out"))
              ],
            ))));
  }
}
