import 'package:flutter/material.dart';
import 'package:movil_parcial_frontend/product.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'favs_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCard extends StatefulWidget {
  final String index;
  final String sArticleName;
  final String sSeller;
  final double score;
  final String uImage;
  bool favoriteFlag;

  ProductCard(this.index, this.sArticleName, this.sSeller, this.score,
      this.uImage, this.favoriteFlag,
      {super.key});

  @override
  State<ProductCard> createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  // function to call sqlite to add the article to favs
  // todo unique index
  Future<void> addToFav(index, sArticleName, sSeller, score, uImage) async {
    final item = Product(
      id: index,
      title: sArticleName,
      seller: sSeller,
      rating: score,
      img: uImage,
    );

    await FavoritesDatabase.instance.addFavorites(item);
  }

  // call instance of database todo delete
  Future<void> deleteToFav(indexItem) async {
    await FavoritesDatabase.instance.deleteFavorites(indexItem);
  }

  // this send to the back a list of current favs
  updateFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var favorites = await FavoritesDatabase.instance.getFavorites();
    String token = prefs.getString("accessToken").toString();
    // todo
    await http.post(Uri.parse('http://10.0.2.2:8080/user/favorites'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "accessToken": token
        },
        body: jsonEncode(<String, dynamic>{
          'favorites': favorites,
        }));
  }

  // function to change state of star
  void _statusFavorite() {
    setState(() {
      if (widget.favoriteFlag) {
        widget.favoriteFlag = false;
        deleteToFav(widget.index);
        updateFavorites();
      } else {
        widget.favoriteFlag = true;
        addToFav(widget.index, widget.sArticleName, widget.sSeller,
            widget.score, widget.uImage);
        updateFavorites();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // todo
    /* var changesFavorites =
        Provider.of<ChangesInFavorites>(context, listen: false)
            .rebuildFavorites(); */
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        border: Border.all(color: Colors.lightBlue),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Image(
            image: NetworkImage(widget.uImage),
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 3,
          ),
          // to help wrapping the text of overflows
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                widget.sArticleName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,
              ),
              Text(
                "Vendedor: ${widget.sSeller}",
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.clip,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Calificaci??n: ${widget.score}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      iconSize: 30,
                      icon: (widget.favoriteFlag
                          ? const Icon(
                              Icons.star,
                            )
                          : const Icon(Icons.star_border)),
                      color: Colors.amberAccent,
                      onPressed: () {
                        _statusFavorite();
                      },
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
