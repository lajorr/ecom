import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';

import '../../domain/entity/cart_product_entity.dart';

abstract class CheckoutDataSource {
  Future<void> addProductToCart(CartProduct product);
  Future<CartModel> fetchCartProducts();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final FireAuth fireAuth;
  final List<CartProduct> _cartList = [];

  CheckoutDataSourceImpl({required this.fireAuth});

  @override
  Future<void> addProductToCart(CartProduct cartProduct) async {
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

      final existingValue = _cartList[existingValueIndex];
      _cartList[existingValueIndex] = CartProduct(
        product: existingValue.product,
        quantity: existingValue.quantity + cartProduct.quantity,
      );
    } else {
      _cartList.add(cartProduct);
    }
  }

  @override
  Future<CartModel> fetchCartProducts() async {
    double total = 0;

    for (var cartItem in _cartList) {
      total += (cartItem.product.price * cartItem.quantity);
    }

    final cartModel = CartModel(
        cId: DateTime.now().toString(),
        user: await fireAuth.getCurrentUserModel(),
        products: _cartList,
        amount: total);
    return cartModel;
  }
}
