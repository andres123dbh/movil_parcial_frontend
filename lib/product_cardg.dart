import 'package:flutter/material.dart';

class ProductCardAlt extends StatefulWidget {
  final String sArticleName;
  final String sSeller;
  final double score;
  final String uImage;
  const ProductCardAlt(this.sArticleName, this.sSeller, this.score, this.uImage,
      {super.key});

  @override
  State<ProductCardAlt> createState() => _ProductCardAlt();
}

class _ProductCardAlt extends State<ProductCardAlt> {
  bool _isFav = false;
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
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(3),
      width: 196,
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
          ),
          const SizedBox(
            height: 3,
          ),
          // to help wrapping the text of overflows
          Text(
            widget.sArticleName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                  padding: const EdgeInsets.all(0),
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
      ),
    );
  }
}
