import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String sArticleName;
  final String sSeller;
  final double score;
  final String uImage;

  const ProductCard(this.sArticleName, this.sSeller, this.score, this.uImage,
      {super.key});

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
            image: NetworkImage(uImage),
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
                sArticleName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text(
                "Vendedor: $sSeller",
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.clip,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Calificación: $score",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(
                        Icons.star_border_outlined,
                      ),
                      onPressed: () {
                        print("object");
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
