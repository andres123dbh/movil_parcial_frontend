import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_parcial_frontend/favs_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'product_card.dart';
import './products_app.dart';
import './view_products/grid_favorite_products.dart';
import './login/login.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritesList();
  }
}

class _FavoritesList extends State<FavoritesList> {
  Map data = {};
  List productsData = [];

  late Widget list = Container();
  Future setFavorites() async {
    var favorites = await FavoritesDatabase.instance.getFavorites();
    productsData = favorites;
    setState(() {
      list = ListView.builder(
          itemCount: productsData.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
                "${productsData[index]['id']}",
                "${productsData[index]['title']}",
                "${productsData[index]['seller']}",
                double.parse("${productsData[index]['rating']}"),
                "${productsData[index]['img']}",
                true);
          });
    });
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const url = 'http://10.0.2.2:8080/products/get';

    String? token = prefs.getString("accessToken");  
    if (token != null) {
        http.Response response = await http.get(Uri.parse(url),headers: {"accessToken": token});
        if (response.statusCode != 200) {
          Get.to(() => const Login());
        }
    } else {
      Get.to(() => const Login());
    }
    
  }

  @override
  void initState() {
    super.initState();
    setFavorites();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Favorite List'),
            ),
            body: productsData.isEmpty
                ? const Center(
                    child: Text("You don't have favorites"),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.05),
                            ElevatedButton(
                              onPressed: () => Get.to(() => const ProductsApp()),
                              child: const Text("Menu")),
                            SizedBox(width: MediaQuery.of(context).size.width*0.6),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.change_circle,
                                  size: 40,
                                  color: Colors.pinkAccent, 
                                ),
                                onPressed: () {
                                  Get.to(() => const FavoriteProductListGrid());
                                },
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: list))
                    ],
                  )));
  }
}
