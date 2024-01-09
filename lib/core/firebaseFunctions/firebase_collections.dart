import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/shared/likes/like_model.dart';

import '../../shared/catalog/model/product_model.dart';
import 'firebase_auth.dart';

class FireCollections {
  final FireAuth fireAuth = FireAuth();

  final productCollection = FirebaseFirestore.instance.collection('products');
  final likesCollection = FirebaseFirestore.instance.collection('likes');

  Future<List<ProductModel>> getAllProductsFromCollection() async {
    final querySnapshot = await productCollection.get();

    List<ProductModel> productListToReturn = [];

    final productsListFromFirebase = querySnapshot.docs;

    if (productsListFromFirebase.isNotEmpty) {
      for (var product in productsListFromFirebase) {
        productListToReturn.add(ProductModel.fromJson(product.data()));
      }
    }

    return productListToReturn;
  }

  Future<LikeModel?> getUserLikeProd(String prodId) async {
    final userId = await fireAuth.getCurrentUserId();

    final snapshot = await likesCollection
        .where('user_id', isEqualTo: userId)
        .where('prod_id', isEqualTo: prodId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final likedProdDoc = snapshot.docs[0];

      final likeProd = likedProdDoc.data();

      return LikeModel.fromMap(likeProd);
    } else {
      createDocument(prodId);
      return null;
    }
  }

  void createDocument(String prodId) async {
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    // Data to be stored in the document
    Map<String, dynamic> data = {
      'prod_id': prodId,
      'user_id': currentUserId,
      'prod_ref': 'products/$prodId',
      'user_ref': 'products/$currentUserId',
      'is_liked': false,
    };

    try {
      // Add the data to Firestore
      await likesCollection.add(data);
    } catch (e) {
      throw DocumentException();
    }
  }

  Future<bool?> updateFavStatus(String prodId) async {
    final userId = await fireAuth.getCurrentUserId();

    final snapshot = await likesCollection
        .where('prod_id', isEqualTo: prodId)
        .where('user_id', isEqualTo: userId)
        .get();

    final docData = snapshot.docs[0].data();
    final currentFavStatus = docData['is_liked'] as bool;
    final docId = snapshot.docs[0].id;
    DocumentReference docRef = likesCollection.doc(docId);

    try {
      await docRef.update({
        'is_liked': !currentFavStatus,
      });

      final favStatus = snapshot.docs[0].data()['is_liked'] as bool;
      return favStatus;
    } catch (e) {
      throw DocumentException();
    }
  }
}
