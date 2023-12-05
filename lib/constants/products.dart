import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/models/product.dart';

// const List<String> imageList = [
//   image1,
//   image2,
//   image3,
//   image4,
// ];

List<Product> productList = [
  Product(
    image: image1,
    title: "Modern Light Clothes",
    category: "Dress Modern",
    price: 100,
    rating: 5,
  ),
  Product(
    image: image2,
    title: "Modern Light Clothes",
    category: "Dress Modern",
    price: 212,
    rating: 4,
  ),
  Product(
    image: image3,
    title: "Modern Light Clothes",
    category: "Dress Modern",
    price: 265,
    rating: 3.5,
  ),
  Product(
    image: image4,
    title: "Modern Light Clothes",
    category: "Dress Modern",
    price: 323,
    rating: 4.8,
  ),
];
void changeFav(Product product) {
  product.isFav = !product.isFav;
}
