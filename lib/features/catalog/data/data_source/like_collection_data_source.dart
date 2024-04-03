import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/shared/likes/like_model.dart';

abstract class LikeCollectionDataSource {
  Future<LikeModel> fetchLikeDocument(String prodId);
  Future<bool?> likeUnlikeProd(String prodId);
}

class LikeCollectionDataSourceImpl implements LikeCollectionDataSource {

  LikeCollectionDataSourceImpl({required this.fireCollections});
  final FireCollections fireCollections;

  @override
  Future<LikeModel> fetchLikeDocument(String prodId) async {
    return await fireCollections.getUserLikeProd(prodId);
  }

  @override
  Future<bool?> likeUnlikeProd(String prodId) async {
    return await fireCollections.updateFavStatus(prodId);
  }
}
