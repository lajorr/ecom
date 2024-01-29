import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

abstract class FavoritesDataSource {
  Future<List<ProductModel>> fetchFavProducts();
}

class FavoritesDataSourceImpl implements FavoritesDataSource {
  final FireCollections fireCollections;

  FavoritesDataSourceImpl({required this.fireCollections});
  @override
  Future<List<ProductModel>> fetchFavProducts() async {
    return await fireCollections.fetchFavProducts();
  }
}
