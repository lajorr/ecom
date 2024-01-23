import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/core/extensions/string_to_enum.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/order_model.dart';

import '../../features/checkout/domain/model/cart_model.dart';
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
  final ordersCollection = FirebaseFirestore.instance.collection('orders');

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

  Future<LikeModel> getUserLikeProd(String prodId) async {
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
      return createDocument(prodId);
    }
  }

  Future<LikeModel> createDocument(String prodId) async {
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
      final newLikeDoc = await likesCollection.add(data);
      final docSnapshot = await newLikeDoc.get();
      final docData = docSnapshot.data()!;
      return LikeModel.fromMap(docData);
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
      // 'cid': "${cart.user.uid}-cartId",
      'products': prodRefList,
      'user': userRef,
      'amount': cart.amount,
      'status': cart.cartStatus.name
    };

    try {
      final userCart =
          await cartCollection.where('user', isEqualTo: userRef).get();
      if (userCart.docs.isNotEmpty) {
        final userDocId = userCart.docs[0].id;
        cartCollection.doc(userDocId).set(data);
      }
    } catch (e) {
      throw DocumentException();
    }
  }

  Future<CartModel> fetchCartItems() async {
    List<CartProductModel> cartProdList = [];
    CartModel currentCart;

    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    try {
      final snapshot =
          await cartCollection.where('user', isEqualTo: userRef).get();

      if (snapshot.docs.isNotEmpty) {
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

        currentCart = CartModel(
          // cId: docData['cid'],
          user: await fireAuth.getCurrentUserModel(), // userId
          products: cartProdList,
          amount: docData['amount'],
          cartStatus: (docData['status'] as String).toCartStatus(),
        );
      } else {
        currentCart = await createEmptyCart(
          currentUser: currentUser,
          userId: currentUserId,
          userRef: userRef,
        );
      }
      return currentCart;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<CartModel> createEmptyCart({
    required String userId,
    required DocumentReference<Map<String, dynamic>> userRef,
    required UserModel currentUser,
  }) async {
    final data = {
      'products': <Map<String, dynamic>>[],
      'user': userRef,
      'amount': 0.00,
      'status': CartStatus.cartCreated.name
    };
    // await cartCollection.doc("$userId-cartId").set(data);
    final docRef = await cartCollection.add(data);
    final cart = CartModel(
      cId: docRef.id,
      user: currentUser,
      products: data['products'] as List<CartProductModel>,
      amount: 0,
      
    );

    return cart;
  }

  Future<void> clearAllCartItems() async {
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final data = {
      'cid': "$currentUserId-cartId",
      'products': [],
      'user': userRef,
      'amount': 0.00,
      'status': CartStatus.cartCreated.name,
    };

    // ordersCollection.doc('$currentUserId-orders').set(currentCart.)

    final userCart =
        await cartCollection.where('user', isEqualTo: userRef).get();
    if (userCart.docs.isNotEmpty) {
      final userDocId = userCart.docs[0].id;
      cartCollection.doc(userDocId).set(data);
    }
  }

  Future<OrderModel> fetchOrders() async {
    final OrderModel order;
    final List<CartModel> cartList;

    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final userOrder =
        await cartCollection.where('user', isEqualTo: userRef).get();

    if (userOrder.docs.isNotEmpty) {
      // final userDocId = userOrder.docs[0].id;
      // ordersCollection.doc(userDocId).set(orderData);
      cartList = userOrder.docs[0].data()['carts'];

      order = OrderModel(
        user: userRef,
        cartList: cartList,
      );
    } else {
      order = OrderModel(user: userRef, cartList: const []);
    }

    return order;
  }

  Future<void> cartToOrderCollection(
       List<Map<String, dynamic>> cartList) async {
    
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);
    final orderData = {
      'user': userRef,
      'carts': cartList,
    };

    final userOrder =
        await ordersCollection.where('user', isEqualTo: userRef).get();

    if (userOrder.docs.isNotEmpty) {
      
      final userDocId = userOrder.docs[0].id;
      ordersCollection.doc(userDocId).set(orderData);
    } else {
      
      ordersCollection.add(orderData);
    }

    clearAllCartItems();
  }

  Future<void> removeItemFromCart(CartModel cart) async {
    // removing the data by updating the curreng cartModel json with new one..
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
      // 'cid': "${cart.user.uid}-cartId",
      'products': prodRefList,
      'user': userRef,
      'amount': cart.amount,
    };

    try {
      final userCart =
          await cartCollection.where('user', isEqualTo: userRef).get();
      if (userCart.docs.isNotEmpty) {
        final userDocId = userCart.docs[0].id;
        cartCollection.doc(userDocId).set(data);
      }
    } catch (e) {
      throw DocumentException();
    }
  }
}
