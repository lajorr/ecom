import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

abstract class FavoritesDataSource {
  Future<List<ProductModel>> fetchFavProducts();
}

class FavoritesDataSourceImpl implements FavoritesDataSource {

  FavoritesDataSourceImpl({required this.fireCollections});
  final FireCollections fireCollections;
  @override
  Future<List<ProductModel>> fetchFavProducts() async {
    return await fireCollections.fetchFavProducts();
  }
}
