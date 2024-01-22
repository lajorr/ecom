import '../../../../core/firebaseFunctions/firebase_auth.dart';
import '../../../../core/firebaseFunctions/firebase_collections.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/cart_product_model.dart';

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

  List<CartProductModel> _cartList = [];

  double _amount = 0;

  @override
  Future<CartModel> addProductToCart(CartProductModel cartProduct) async {
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
      final existingValueIndex =
          _cartList.indexWhere((cp) => cp.product.id == cartProduct.product.id);

      final existingValue = _cartList[existingValueIndex];

      _cartList[existingValueIndex] = CartProductModel(
        product: existingValue.product,
        quantity: existingValue.quantity + cartProduct.quantity,
      );
      //* retotalling
      for (var cartItem in _cartList) {
        total += (cartItem.product.price * cartItem.quantity);
      }
      _amount = total;
      cartModel = CartModel(
          cId: DateTime.now().toString(),
          user: await fireAuth.getCurrentUserModel(),
          products: _cartList,
          amount: double.parse((_amount).toStringAsFixed(2)));
    } else {
      _cartList.add(cartProduct);

      for (var cartItem in _cartList) {
        total += (cartItem.product.price * cartItem.quantity);
      }

      _amount = total;

      cartModel = CartModel(
        cId: DateTime.now().toString(),
        user: await fireAuth.getCurrentUserModel(),
        products: _cartList,
        amount: double.parse(_amount.toStringAsFixed(2)),
      );
    }

    fireCollections.storeCartProducts(cartModel);
    return cartModel;
  }

  @override
  Future<CartModel> fetchCartProducts() async {
    final userId = await fireAuth.getCurrentUserId();

    if (_cartList.isNotEmpty) {
      final cart = CartModel(
        cId: "$userId-cartId",
        user: await fireAuth.getCurrentUserModel(), // userId
        products: _cartList,
        amount: _amount,
      );
      return cart;
    }

    final fireData = await fetchFromFirebase();
    return fireData;
  }

  Future<CartModel> fetchFromFirebase() async {
    final cartModel = await fireCollections.fetchCartItems();
    _cartList = cartModel.products;
    _amount = cartModel.amount;
    return cartModel;
  }

  @override
  Future<void> clearAllCartItems() async {
    _cartList.clear();
    _amount = 0;
    await fireCollections.clearAllCartItems();
  }

  @override
  Future<CartModel> removeCartItem(ProductModel prod) async {
    double total = 0;
    final userId = await fireAuth.getCurrentUserId();

    _cartList.removeWhere((cartItem) => cartItem.product.id == prod.id);

    for (var cartItem in _cartList) {
      total += (cartItem.product.price * cartItem.quantity);
    }
    _amount = total;

    final cartModel = CartModel(
      cId: "$userId-cartId",
      user: await fireAuth.getCurrentUserModel(),
      products: _cartList,
      amount: double.parse(_amount.toStringAsFixed(2)),
    );

    fireCollections.removeItemFromCart(cartModel);
    return cartModel;
  }
}
