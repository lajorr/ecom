import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';

abstract class CheckoutDataSource {
  Future<void> addProductToCart(CartProduct product);
  Future<List<CartProduct>> fetchCartProducts();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final Map<String, CartProduct> _cartList = {};

  @override
  Future<void> addProductToCart(CartProduct cartProduct) async {
    print("ADDING PRODUCT TO CART!?");

    if (_cartList.containsKey(cartProduct.product.id)) {
      _cartList.update(
        cartProduct.product.id,
        (existingValue) => CartProduct(
          product: existingValue.product,
          quantity: existingValue.quantity + cartProduct.quantity,
        ),
      );
      print("QUANTITY INCREASED");
    } else {
      _cartList.putIfAbsent(cartProduct.product.id, () => cartProduct);
      print("NEW PROD ADDED");
    }
  }

  @override
  Future<List<CartProduct>> fetchCartProducts() {
    if (_cartList.isEmpty) {
      print("EMPTY");
    }
    print(_cartList);

    throw UnimplementedError();
  }
}
