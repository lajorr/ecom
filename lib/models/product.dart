// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String title;
  final String category;
  final String image;
  final double price;
  final double rating;
  bool isFav;

  Product({
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    this.isFav = false,
  });
}
