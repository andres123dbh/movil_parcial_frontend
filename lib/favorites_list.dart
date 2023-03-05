import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movil_parcial_frontend/favorites_changes_notification.dart';
import 'package:movil_parcial_frontend/favs_database.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'product_card.dart';

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
  //todo
  Future testing() async {
    var x = await FavoritesDatabase.instance.getFavorites();
    productsData = x;
    setState(() {
      list = ListView.builder(
          itemCount: productsData.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
                index,
                "${productsData[index]['title']}",
                "${productsData[index]['seller']}",
                double.parse("${productsData[index]['rating']}"),
                "${productsData[index]['img']}",
                true);
          });
    });
  }

  //todo
  /* getFavoritesLocal() async {
    var x = await FavoritesDatabase.instance.getFavorites();
    setState(() {
      productsData = x;
    });
  } */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getFavoritesLocal();
  }

  @override
  Widget build(BuildContext context) {
    testing();
    //getFavoritesLocal();
    /* var changesFavorites =
        Provider.of<ChangesInFavorites>(context, listen: false)
            .rebuildFavorites(); */
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Favorite List'),
            ),
            // TODO make change of status between 2 type of views - delete this when is ready
            body: productsData.isEmpty
                ? const Center(
                    child: Text("You don't have favorites"),
                  )
                : Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 10),
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
                              //todo
                              child: list))
                    ],
                  )));
  }
}
