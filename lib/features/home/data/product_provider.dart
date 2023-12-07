import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/shared/product/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _productList = [
    Product(
      image: ImageConstants.image1,
      title: "Modern Light Clothes",
      category: "Dress Modern",
      price: 100,
      rating: 5,
    ),
    Product(
      image: ImageConstants.image2,
      title: "Modern Light Clothes",
      category: "Dress Modern",
      price: 212,
      rating: 4,
    ),
    Product(
      image: ImageConstants.image3,
      title: "Modern Light Clothes",
      category: "Dress Modern",
      price: 265,
      rating: 3.5,
    ),
    Product(
      image: ImageConstants.image4,
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
