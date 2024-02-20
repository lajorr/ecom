import '../../../../core/firebaseFunctions/firebase_collections.dart';
import '../../../../shared/catalog/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getAllProductList();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FireCollections fireCollection;

  ProductDataSourceImpl({required this.fireCollection});
  @override
  Future<List<ProductModel>> getAllProductList() async {
    return await fireCollection.getAllProductsFromCollection();
  }
}
