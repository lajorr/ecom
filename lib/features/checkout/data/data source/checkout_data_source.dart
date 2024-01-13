import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';

abstract class CheckoutDataSource {
  Future<CartModel> addProductToCart(CartProductModel product);
  Future<CartModel> fetchCartProducts();
  Future<void> clearAllCartItems();
  Future<CartModel> removeCartItem(ProductModel prod);
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  CheckoutDataSourceImpl({
    required this.fireAuth,
    required this.fireCollections,
  });

  final FireAuth fireAuth;
  final FireCollections fireCollections;

  final List<CartProductModel> _cartList = [];

  double _amount = 0;

  @override
  Future<CartModel> addProductToCart(CartProductModel cartProduct) async {
    print("inside add function");
    final CartModel cartModel;
    double total = 0;
    bool exists = false;
    for (var cartItem in _cartList) {
      if (cartItem.product.id == cartProduct.product.id) {
        exists = true;
        break;
      }
    }
    if (exists) {
      print("product exists");
      final existingValueIndex =
          _cartList.indexWhere((cp) => cp.product.id == cartProduct.product.id);

      print("INDEXXX $existingValueIndex");

      final existingValue = _cartList[existingValueIndex];
      // total = existingValue.;

      _cartList[existingValueIndex] = CartProductModel(
        product: existingValue.product,
        quantity: existingValue.quantity + cartProduct.quantity,
      );
      //* retotalling
      for (var cartItem in _cartList) {
        print("QUANTITY ${cartItem.quantity}");
        total += (cartItem.product.price * cartItem.quantity);
      }
      _amount = total;
      cartModel = CartModel(
          cId: DateTime.now().toString(),
          user: await fireAuth.getCurrentUserModel(),
          products: _cartList,
          amount: double.parse((_amount).toStringAsFixed(2)));
      // fireCollections.storeCartProducts(cartModel);
    } else {
      _cartList.add(cartProduct);

      print(_cartList);

      print("AFTERDATACARTLIST ${_cartList.length}");

      for (var cartItem in _cartList) {
        total += (cartItem.product.price * cartItem.quantity);
      }
      print("TOTAALL $total");
      _amount = total;

      cartModel = CartModel(
        cId: DateTime.now().toString(),
        user: await fireAuth.getCurrentUserModel(),
        products: _cartList,
        amount: double.parse(_amount.toStringAsFixed(2)),
      );
      print('TOTS ${cartModel.amount}');
    }

    return cartModel;

    print("PROD ADDED -- $_cartList");
    // fireCollections.storeCartProducts(cartModel);
  }

  @override
  Future<CartModel> fetchCartProducts() async {
    print("FETCHED");
    // final cartModel = await fireCollections.fetchCartItems();
    // _cartList = cartModel.products;
    // _amount = cartModel.amount;
    // print("CARTLIST $_amount");

    // for (var cartItem in _cartList) {
    //   _amount += cartItem.quantity * cartItem.product.price;
    // }
    final userId = await fireAuth.getCurrentUserId();
    final cart = CartModel(
      cId: "$userId-cartId",
      user: await fireAuth.getCurrentUserModel(), // userId
      products: _cartList,
      amount: _amount,
    );
    print("DATA SOURCE ${cart.amount}");
    return cart;
  }

  @override
  Future<void> clearAllCartItems() async {
    _cartList.clear();
    _amount = 0;
    // return await fireCollections.clearAllCartItems();
  }

  @override
  Future<CartModel> removeCartItem(ProductModel prod) async {
    print("BEFORE REMOVE CARTLIST $_cartList");
    _cartList.removeWhere((cartItem) => cartItem.product.id == prod.id);
    print("AFTER REMOVE CARTLIST ${_cartList.length}");

    double total = 0;

    for (var cartItem in _cartList) {
      total += (cartItem.product.price * cartItem.quantity);
    }
    _amount = total;

    final userId = await fireAuth.getCurrentUserId();

    final cartModel = CartModel(
      cId: "$userId-cartId", // as i wont be updating this
      user: await fireAuth.getCurrentUserModel(),
      products: _cartList,
      amount: double.parse(_amount.toStringAsFixed(2)),
    );

    print("DATA SOURCE $cartModel");

    // fireCollections.removeItemFromCart(cartModel);
    return cartModel;
  }
}
