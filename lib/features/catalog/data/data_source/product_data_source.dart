import '../../../../core/firebaseFunctions/firebase_collections.dart';

import '../../../../shared/catalog/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProductList();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FireCollections fireCollection;

  ProductDataSourceImpl({required this.fireCollection});
  @override
  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> productList =
        await fireCollection.getAllProductsFromCollection();

    return productList;
  }
}
