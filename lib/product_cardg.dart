import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movil_parcial_frontend/product.dart';
import 'favs_database.dart';

class ProductCardAlt extends StatefulWidget {
  final String index;
  final String sArticleName;
  final String sSeller;
  final double score;
  final String uImage;
  bool favoriteFlag;
  ProductCardAlt(this.index, this.sArticleName, this.sSeller, this.score,
      this.uImage, this.favoriteFlag,
      {super.key});

  @override
  State<ProductCardAlt> createState() => _ProductCardAlt();
}

class _ProductCardAlt extends State<ProductCardAlt> {
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
    var favorites = await FavoritesDatabase.instance.getFavorites();
    await http.post(Uri.parse('http://10.0.2.2:8080/user/favorites'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width*0.45,
      height: 215,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        border: Border.all(color: Colors.lightBlue),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Image(
            image: NetworkImage(widget.uImage),
            fit: BoxFit.fitWidth,
            height: 100,
          ),
          const SizedBox(
            height: 3,
          ),
          // to help wrapping the text of overflows
          AutoSizeText(
              widget.sArticleName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Vendedor: ${widget.sSeller}",
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calificación: ${widget.score}",
                style: const TextStyle(fontSize: 12),
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
                        // todo
                        _statusFavorite();
                      },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
