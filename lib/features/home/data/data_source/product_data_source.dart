import '../../../../product_json_data/product_json.dart';
import '../../../../shared/product/model/product_global_model.dart';
import 'package:flutter/material.dart';

abstract class ProductDataSource {
  List<Product> getProductList();
}

class ProductDataSourceImpl implements ProductDataSource {
  List<Product> productList = [];

  @override
  List<Product> getProductList() {
    try {
      for (var prod in productData) {
        var product = Product.fromJson(prod);
        productList.add(product);
      }

      return productList;
    } catch (e) {
      debugPrint("error");
      return [];
    }
  }
}
