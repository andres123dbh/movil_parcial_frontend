class Product {
  late final int id;
  late final String title;
  late final String seller;
  late final double rating;
  late final String img;

  Product({
    required this.id,
    required this.title,
    required this.seller,
    required this.rating,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'seller': seller,
      'rating': rating,
      'img': img
    };
  }
}
