import 'package:ecom/shared/catalog/model/product_model.dart';

import '../../../../core/firebaseFunctions/firebase_collections.dart';
import '../../../../shared/likes/like_model.dart';

abstract class LikeCollectionDataSource {
  Future<LikeModel> createLikeDocument(String prodId);
  Future<LikeModel> fetchLikeDocument(String prodId);
  Future<bool?> likeUnlikeProd(String prodId);
  Future<List<ProductModel>> fetchFavProducts();
}

class LikeCollectionDataSourceImpl implements LikeCollectionDataSource {
  final FireCollections fireCollections;

  LikeCollectionDataSourceImpl({required this.fireCollections});
  @override
  Future<LikeModel> createLikeDocument(String prodId) async {
    return await fireCollections.createDocument(prodId);
  }

  @override
  Future<LikeModel> fetchLikeDocument(String prodId) async {
    return await fireCollections.getUserLikeProd(prodId);
  }

  @override
  Future<bool?> likeUnlikeProd(String prodId) async {
    return fireCollections.updateFavStatus(prodId);
  }

  @override
  Future<List<ProductModel>> fetchFavProducts() async {
    final prodList = await fireCollections.fetchFavProducts();
    return prodList;
  }
}
