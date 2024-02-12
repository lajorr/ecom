import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/features/chat/data/model/message_model.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';
import 'package:geocoding/geocoding.dart';

import '../../features/auth/data/model/user_model.dart';
import '../../features/checkout/domain/entity/enums/cart_status_enum.dart';
import '../../features/checkout/domain/model/cart_model.dart';
import '../../features/checkout/domain/model/cart_product_model.dart';
import '../../features/checkout/domain/model/order_model.dart';
import '../../shared/catalog/model/product_model.dart';
import '../../shared/likes/like_model.dart';
import '../error/exception.dart';
import '../extensions/string_to_enum.dart';
import 'firebase_auth.dart';

class FireCollections {
  final FireAuth fireAuth = FireAuth();

  final productCollection = FirebaseFirestore.instance.collection('products');
  final likesCollection = FirebaseFirestore.instance.collection('likes');
  final cartCollection = FirebaseFirestore.instance.collection('cart');
  final userCollection = FirebaseFirestore.instance.collection('users');
  final ordersCollection = FirebaseFirestore.instance.collection('orders');
  final chatRoomsCollection =
      FirebaseFirestore.instance.collection('chat-rooms');

  final creditCardCollection =
      FirebaseFirestore.instance.collection('credit-cards');

  Future<void> setUserData({required UserModel user, String? imageUrl}) async {
    UserModel userData = user;
    if (imageUrl != null) {
      userData = user.copyWith(imageUrl: imageUrl);
    }

    final userJson = userData.toMap();
    try {
      await userCollection.doc(user.uid).set(userJson);
    } on FirebaseException {
      throw FirebaseException;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<ProductModel>> getAllProductsFromCollection() async {
    final querySnapshot = await productCollection.get();

    List<ProductModel> productListToReturn = [];

    final productsListFromFirebase = querySnapshot.docs;

    if (productsListFromFirebase.isNotEmpty) {
      for (var product in productsListFromFirebase) {
        UserModel? owner;
        final prodJson = product.data();

        final ownerRef =
            prodJson['owner'] as DocumentReference<Map<String, dynamic>>?;
        if (ownerRef != null) {
          owner = await getUserFromRef(ownerRef);
        }

        productListToReturn.add(ProductModel.fromJson(prodJson, owner));
      }
    }

    return productListToReturn;
  }

  Future<UserModel> getUserFromRef(DocumentReference ownerRef) async {
    final ownerSnapshot = await ownerRef.get();
    final ownerJson = ownerSnapshot.data() as Map<String, dynamic>;

    final owner = UserModel.fromMap(ownerJson);
    return owner;
  }

  Future<LikeModel> getUserLikeProd(String prodId) async {
    final userId = fireAuth.getCurrentUserId();

    final snapshot = await likesCollection
        .where('user_id', isEqualTo: userId)
        .where('prod_id', isEqualTo: prodId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final likedProdDoc = snapshot.docs[0];

      final likeProd = likedProdDoc.data();

      return LikeModel.fromMap(likeProd);
    } else {
      return await createDocument(prodId);
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

  Future<List<ProductModel>> fetchFavProducts() async {
    List<ProductModel> favProducts = [];
    final userId = fireAuth.getCurrentUserId();

    try {
      final snapshot = await likesCollection
          .where('user_id', isEqualTo: userId)
          .where('is_liked', isEqualTo: true)
          .get();

      final likedDocs = snapshot.docs;

      for (var doc in likedDocs) {
        UserModel? owner;
        final data = doc.data();
        final prodRef =
            await (data['prod_ref'] as DocumentReference<Map<String, dynamic>>)
                .get();

        final prodData = prodRef.data()!;
        final ownerRef =
            prodData['owner'] as DocumentReference<Map<String, dynamic>>;
        owner = await getUserFromRef(ownerRef);
        owner = await getUserFromRef(ownerRef);
        final prodM = ProductModel.fromJson(prodData, owner);
        favProducts.add(prodM);
      }
    } catch (e) {
      throw ServerException();
    }

    return favProducts;
  }

  Future<bool?> updateFavStatus(String prodId) async {
    final userId = fireAuth.getCurrentUserId();

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
      'products': prodRefList,
      'user': userRef,
      'amount': cart.amount,
      'status': cart.cartStatus.name,
      'lat': cart.lat,
      'lng': cart.lng
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
          final ownerRef = prodRefJsonData['owner']
              as DocumentReference<Map<String, dynamic>>;
          final owner = await getUserFromRef(ownerRef);
          final prodM = ProductModel.fromJson(prodRefJsonData, owner);

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
          lat: docData['lat'] as double?,
          lng: docData['lng'] as double?,
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
      'status': CartStatus.cartCreated.name,
    };

    final docRef = await cartCollection.add(data);
    final cart = CartModel(
      cId: docRef.id,
      user: currentUser,
      products: const [],
      amount: 0,
      lat: null,
      lng: null,
    );

    return cart;
  }

  Future<void> clearAllCartItems() async {
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final data = {
      'products': [],
      'user': userRef,
      'amount': 0.00,
      'status': CartStatus.cartCreated.name,
    };

    final userCart =
        await cartCollection.where('user', isEqualTo: userRef).get();
    if (userCart.docs.isNotEmpty) {
      final userDocId = userCart.docs[0].id;
      cartCollection.doc(userDocId).set(data);
    }
  }

  Future<OrderModel> fetchOrders() async {
    final OrderModel order;
    List<CartModel> cartList = [];

    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final userOrder =
        await ordersCollection.where('user', isEqualTo: userRef).get();

    if (userOrder.docs.isNotEmpty) {
      final fetchedOrder = userOrder.docs[0].data();
      final carts = fetchedOrder['carts'] as List;

      for (var c in carts) {
        List<CartProductModel> cartProdList = [];
        final prodList = c['products'] as List;

        for (var prod in prodList) {
          UserModel? owner;
          final prodJson = prod['product'];
          final ownerRef =
              (prodJson['owner'] as DocumentReference<Map<String, dynamic>>?);

          if (ownerRef != null) {
            owner = await getUserFromRef(ownerRef);
          }
          final prodM = ProductModel.fromJson(prodJson, owner);

          final cartM = CartProductModel(
            product: prodM,
            quantity: prod['quantity'],
          );

          cartProdList.add(cartM);
        }
        final deliveryLat = c['lat'] as double?;
        final deliveryLng = c['lng'] as double?;

        final deliveryLocation = await placemarkFromCoordinates(
          deliveryLat!,
          deliveryLng!,
        );
        final deliveryAddress = deliveryLocation.first.subLocality;
        final cartM = CartModel(
          user: await fireAuth.getCurrentUserModel(), // userId
          products: cartProdList,
          amount: c['amount'] as double,
          cartStatus: (c['status'] as String).toCartStatus(),
          lat: deliveryLat,
          lng: deliveryLng,

          address: deliveryAddress,
        );

        cartList.add(cartM);
      }

      order = OrderModel(
        user: currentUser,
        cartList: cartList,
      );
    } else {
      List<CartModel> emptyList = [];
      order = OrderModel(
        user: currentUser,
        cartList: emptyList,
      );
    }

    return order;
  }

  Future<void> cartToOrderCollection(List<CartModel> cartList) async {
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserId = currentUser.uid!;
    final userRef = userCollection.doc(currentUserId);

    final List<Map<String, dynamic>> cartMapList = [];

    for (var cart in cartList) {
      final cartMap = cart.toMap(userRef: userRef);

      cartMapList.add(cartMap);
    }

    final orderData = {
      'user': userRef,
      'carts': cartMapList,
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
      'products': prodRefList,
      'user': userRef,
      'amount': cart.amount,
      'status': cart.cartStatus.name,
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

  Future<void> storeCardInfo(CreditCardModel creditModel) async {
    final user = await fireAuth.getCurrentUserModel();
    final userRef = userCollection.doc(user.uid);

    final creditJson = creditModel.toMap();

    creditJson.addAll(
      {'user': userRef},
    );

    final snapshot =
        await creditCardCollection.where('user', isEqualTo: userRef).get();

    if (snapshot.docs.isNotEmpty) {
      final userCreditId = snapshot.docs[0].id;

      await creditCardCollection.doc(userCreditId).set(creditJson);
    } else {
      await creditCardCollection.add(creditJson);
    }
  }

  Future<CreditCardModel> fetchCreditCardInfo() async {
    final user = await fireAuth.getCurrentUserModel();
    final userRef = userCollection.doc(user.uid);

    try {
      final snapshot =
          await creditCardCollection.where('user', isEqualTo: userRef).get();

      if (snapshot.docs.isNotEmpty) {
        final creditJson = snapshot.docs[0].data();

        final creditM = CreditCardModel.fromMap(creditJson);

        return creditM;
      } else {
        return const CreditCardModel(
          cardNum: null,
          cardHolderName: null,
          cvv: null,
          expiryDate: null,
        );
      }
    } catch (e) {
      throw ServerException();
    }
  }

  //* Chat collectionss

  Future<void> storeMessagesInCollection(MessageModel message) async {
    final member1 = message.sender.uid;
    final member2 = message.reciever.uid;

    final ids = [member1, member2];
    ids.sort(); // so that both the use would have the same chat room..
    final chatRoomId = ids.join('_');

    // covert to json

    final senderRef = userCollection.doc(message.sender.uid);
    final recieverRef = userCollection.doc(message.reciever.uid);

    final msgJson = message.toMap(
      senderRef: senderRef,
      recieverRef: recieverRef,
    );

    final membersData = {
      'members': [userCollection.doc(member1), userCollection.doc(member2)]
    };

    //add message to firestore
    try {
      chatRoomsCollection.doc(chatRoomId)
        ..set(membersData)
        ..collection('messages').add(msgJson);
    } catch (e) {
      throw ServerException();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String user2Id) {
    Stream<QuerySnapshot<Map<String, dynamic>>> allMessagesSnapshot;

    final user1Id = fireAuth.getCurrentUserId();

    final ids = [user1Id, user2Id];
    ids.sort(); // so that both the use would have the same chat room..
    final chatRoomId = ids.join('_');

    try {
      allMessagesSnapshot = chatRoomsCollection
          .doc(chatRoomId)
          .collection("messages")
          .orderBy("created_at", descending: false)
          .snapshots();
      return allMessagesSnapshot;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<DocumentSnapshot<Object?>>> getUserChatRooms() async {
    List<DocumentSnapshot<Object?>> userDocSnapList = [];
    final currentUser = await fireAuth.getCurrentUserModel();
    final currentUserRef = userCollection.doc(currentUser.uid);
    final snapshot = await chatRoomsCollection
        .where('members', arrayContains: currentUserRef)
        .get();
    final docs = snapshot.docs;

    for (var doc in docs) {
      final roomData = doc.data();
      final roomMembers = roomData['members'] as List;

      final otherUserRef = roomMembers
          .where((memberRef) => memberRef != currentUserRef)
          .first as DocumentReference;

      final otherUser = await otherUserRef.get();
      userDocSnapList.add(otherUser);
    }
    return userDocSnapList;
  }
}
