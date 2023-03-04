import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String sArticleName;
  final String sSeller;
  final double score;
  final String uImage;
  const ProductCard(this.sArticleName, this.sSeller, this.score, this.uImage,
      {super.key});

  @override
  State<ProductCard> createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  bool _isFav = false;
  // function to change state of star
  void _statusFavorite() {
    setState(() {
      if (_isFav) {
        _isFav = false;
      } else {
        _isFav = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
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
          ),
          const SizedBox(
            width: 3,
          ),
          // to help wrapping the text of overflows
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.sArticleName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                    "Calificación: ${widget.score}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      iconSize: 30,
                      icon: (_isFav
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
