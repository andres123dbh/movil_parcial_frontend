import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:movil_parcial_frontend/favs_database.dart';


import '../product_cardg.dart';
import '../login/login.dart';
import '../products_app.dart';
import '../favorites_list.dart';

class FavoriteProductListGrid extends StatefulWidget {
  const FavoriteProductListGrid({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteProductListGrid();
  }
}

class _FavoriteProductListGrid extends State<FavoriteProductListGrid> {
  Map data = {};

  late List<dynamic> productList;
  late Widget listView = Container();

  List favorite= [];

  //function to refresh favorite view if a product is deleted
  Future setFavorites() async {
      var favorites = await FavoritesDatabase.instance.getFavorites();
      for (var element in favorites) {
        favorite.add(element['id']);
      }
  }

  Future getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const url = 'http://10.0.2.2:8080/products/get';

    String? token = prefs.getString("accessToken");  
    if (token != null) {
        try {
          http.Response response = await http.get(Uri.parse(url),headers: {"accessToken": token});
          if (response.statusCode == 200) {
            data = jsonDecode(response.body);
            productList = data['products'];
            List <Widget> rowGrid = <Widget>[];
            for (var i = 0; i < productList.length; i++) {
              if (i.isEven) {
                rowGrid.add(Row(children: [
                              if(favorite.contains(productList[i]['_id']))...[
                                ProductCardAlt("${productList[i]['_id']}","${productList[i]['title']}","${productList[i]['seller']}",
                                double.parse("${productList[i]['rating']}"),"${productList[i]['image']}",true)
                              ],
                              if(favorite.contains(productList[i + 1]['_id']))...[
                                ProductCardAlt("${productList[i + 1]['_id']}","${productList[i + 1]['title']}","${productList[i + 1]['seller']}",
                                double.parse("${productList[i + 1]['rating']}"),"${productList[i + 1]['image']}",true)
                              ],
                            ],)
                            );
              }
            }
            setState(() {
              listView = ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: rowGrid.length,
                  itemBuilder: (BuildContext context, int index) {
                    return rowGrid[index];
                  },
                );
            });
          } else{
            Get.to(() => const Login());
          }
        } catch (e) {
          return Error();
        }
    } else {
      Get.to(() => const Login());
    }
    
  }

  @override
  void initState() {
    super.initState();
    setFavorites();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Favorite List'),
            ),
            body: favorite.isEmpty
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
                                  Get.to(() => const FavoritesList());
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
                              //todo
                              child: listView))
                    ],
                  )));
  }
}
