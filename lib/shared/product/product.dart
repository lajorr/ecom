class Product {
  Product({
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    this.isFav = false,
  });

  final String title;
  final String category;
  final String image;
  final double price;
  final double rating;
  bool isFav;

  @override
  String toString() {
    return 'Product(title: $title, category: $category, image: $image, price: $price, rating: $rating, isFav: $isFav)';
  }
}
