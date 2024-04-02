import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getAllProductList();
}

class ProductDataSourceImpl implements ProductDataSource {

  ProductDataSourceImpl({required this.fireCollection});
  final FireCollections fireCollection;
  @override
  Future<List<ProductModel>> getAllProductList() async {
    return await fireCollection.getAllProductsFromCollection();
  }
}
