import '../../domain/entity/cart_product_entity.dart';

abstract class CheckoutDataSource {
  Future<void> addProductToCart(CartProduct product);
  Future<List<CartProduct>> fetchCartProducts();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final List<CartProduct> _cartList = [];

  @override
  Future<void> addProductToCart(CartProduct cartProduct) async {
    print("ADDING PRODUCT TO CART!?");

    // if (_cartList.containsKey(cartProduct.product.id)) {
    //   _cartList.update(
    //     cartProduct.product.id,
    //     (existingValue) => CartProduct(
    //       product: existingValue.product,
    //       quantity: existingValue.quantity + cartProduct.quantity,
    //     ),
    //   );
    //   print("QUANTITY INCREASED");
    // } else {
    //   _cartList.putIfAbsent(cartProduct.product.id, () => cartProduct);
    //   print("NEW PROD ADDED");
    // }
    // if (_cartList.contains(cartProduct.product)) {
    //   final existingValueIndex =
    //       _cartList.indexWhere((cp) => cp == cartProduct);

    //   final existingValue = _cartList[existingValueIndex];
    //   _cartList[existingValueIndex] = CartProduct(
    //     product: existingValue.product,
    //     quantity: existingValue.quantity + cartProduct.quantity,
    //   );
    //   print("QUANTITY INCREASED");
    // } else {
    //   _cartList.add(cartProduct);
    //   print("NEW PROD ADDED");
    // }
    bool exists = false;
    for (var cartItem in _cartList) {
      if (cartItem.product == cartProduct.product) {
        exists = true;
        break;
      }
    }
    if (exists) {
      print('2');
      final existingValueIndex =
          _cartList.indexWhere((cp) => cp.product == cartProduct.product);

      print(existingValueIndex);

      final existingValue = _cartList[existingValueIndex];
      _cartList[existingValueIndex] = CartProduct(
        product: existingValue.product,
        quantity: existingValue.quantity + cartProduct.quantity,
      );

      print("QUANTITY INCREASED");
    } else {
      print('1');
      _cartList.add(cartProduct);
      print("NEW PROD ADDED");
    }
  }

  @override
  Future<List<CartProduct>> fetchCartProducts() async {
    return _cartList;
  }
}
