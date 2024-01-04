import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';

import '../../../../shared/catalog/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProductList();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FireAuth fireAuth;

  ProductDataSourceImpl({required this.fireAuth});
  @override
  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> productList =
        await fireAuth.getAllProductsFromCollection();

    return productList;
  }
}
