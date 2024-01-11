// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/model/cart_product_model.dart';

abstract class CheckoutDataSource {
  Future<void> addProductToCart(CartProductModel product);
  Future<CartModel> fetchCartProducts();
  Future<void> clearCartItems();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final FireAuth fireAuth;
  final FireCollections fireCollections;
  final List<CartProductModel> _cartList = [];

  CheckoutDataSourceImpl({
    required this.fireAuth,
    required this.fireCollections,
  });

  @override
  Future<void> addProductToCart(CartProductModel cartProduct) async {
    final CartModel cartModel;
    double total = 0;
    bool exists = false;
    for (var cartItem in _cartList) {
      if (cartItem.product == cartProduct.product) {
        exists = true;
        break;
      }
    }
    if (exists) {
      final existingValueIndex =
          _cartList.indexWhere((cp) => cp.product == cartProduct.product);
      total = 0;

      final existingValue = _cartList[existingValueIndex];
      _cartList[existingValueIndex] = CartProductModel(
        product: existingValue.product,
        quantity: existingValue.quantity + cartProduct.quantity,
      );

      for (var cartItem in _cartList) {
        total += (cartItem.product.price * cartItem.quantity);
      }
      cartModel = CartModel(
          cId: DateTime.now().toString(),
          user: await fireAuth.getCurrentUserModel(),
          products: _cartList,
          amount: double.parse(total.toStringAsFixed(2)));
    } else {
      _cartList.add(cartProduct);

      total = 0;

      for (var cartItem in _cartList) {
        total += (cartItem.product.price * cartItem.quantity);
      }

      cartModel = CartModel(
        cId: DateTime.now().toString(),
        user: await fireAuth.getCurrentUserModel(),
        products: _cartList,
        amount: double.parse(total.toStringAsFixed(2)),
      );

      fireCollections.storeCartProducts(cartModel);
    }
  }

  @override
  Future<CartModel> fetchCartProducts() async {
    return await fireCollections.fetchCartItems();
  }

  @override
  Future<void> clearCartItems() async {
    _cartList.clear();
    return await fireCollections.clearAllCartItems();
  }
}
