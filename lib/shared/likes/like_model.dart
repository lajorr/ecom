import 'package:ecom/shared/likes/like_entity.dart';

class LikeModel extends Like {
  LikeModel(
      {required super.prodId,
      required super.prodRef,
      required super.userId,
      required super.userRef,
      required super.isLiked});

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      prodId: map['prod_id'],
      prodRef: map['prod_ref'].toString(),
      userId: map['user_id'],
      userRef: map['user_ref'].toString(),
      isLiked: map['is_liked'],
    );
  }
}
