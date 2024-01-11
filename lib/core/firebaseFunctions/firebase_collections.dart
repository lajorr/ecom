import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';

import '../../features/checkout/domain/model/cart_product_model.dart';
import '../../shared/catalog/model/product_model.dart';
import '../../shared/likes/like_model.dart';
import '../error/exception.dart';
import 'firebase_auth.dart';

class FireCollections {
  final FireAuth fireAuth = FireAuth();

  final productCollection = FirebaseFirestore.instance.collection('products');
  final likesCollection = FirebaseFirestore.instance.collection('likes');
  final cartCollection = FirebaseFirestore.instance.collection('cart');
  final userCollection = FirebaseFirestore.instance.collection('users');

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

    final prodRef = productCollection.doc(prodId);
    final userRef = userCollection.doc(currentUserId);
    // Data to be stored in the document
    Map<String, dynamic> data = {
      'prod_id': prodId,
      'user_id': currentUserId,
      'prod_ref': prodRef,
      'user_ref': userRef,
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

  Future<void> storeCartProducts(CartModel cart) async {
    final List<Map<String, dynamic>> prodRefList = [];

    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    for (var product in cart.products) {
      final docRef = productCollection.doc(product.product.id);
      final refMap = {'ref': docRef, 'quantity': product.quantity};
      prodRefList.add(refMap);
    }

    final data = {
      'cid': "${cart.user.uid}-cartId",
      'products': prodRefList,
      'user': userRef,
      'amount': cart.amount,
    };

    try {
      cartCollection.doc('${cart.user.uid}-cartId').set(data);
    } catch (e) {
      throw DocumentException();
    }
  }

  Future<CartModel> fetchCartItems() async {
    List<CartProductModel> cartProdList = [];

    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final snapshot =
        await cartCollection.where('user', isEqualTo: userRef).get();

    final docData = snapshot.docs[0].data();

    final prodList = (docData['products'] as List);

    for (var prod in prodList) {
      final prodRef = await (prod['ref'] as DocumentReference).get();
      final prodRefJsonData =
          prodRef.data() as Map<String, dynamic>; // product json

      final prodM = ProductModel.fromJson(prodRefJsonData);

      final cartM = CartProductModel(
        product: prodM,
        quantity: prod['quantity'],
      );

      cartProdList.add(cartM);
    }

    final cart = CartModel(
        cId: docData['cid'],
        user: await fireAuth.getCurrentUserModel(),
        products: cartProdList,
        amount: docData['amount']);
    return cart;
  }

  Future<void> clearAllCartItems() async {
    print('delteee');
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final cartSnapshot =
        await cartCollection.where('user', isEqualTo: userRef).get();

    print(cartSnapshot.docs);

    final a = cartSnapshot.docs.first.reference.delete();
    print("REFF");
    print(a);
    // await a.delete();
  }
}
