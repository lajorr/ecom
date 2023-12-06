import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _productList = [
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

  List<Product> get productList {
    return _productList;
  }

  List<Product> getFavProd() {
    var list = _productList.where((prod) => prod.isFav).toList();
    return list;
  }

  void changeFav(Product product) {
    product.isFav = !product.isFav;
    notifyListeners();
  }
}
