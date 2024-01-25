import '../../domain/entity/enums/cart_status_enum.dart';
import '../../domain/model/order_model.dart';

import '../../../../core/firebaseFunctions/firebase_auth.dart';
import '../../../../core/firebaseFunctions/firebase_collections.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/cart_product_model.dart';

abstract class CheckoutDataSource {
  Future<CartModel> addProductToCart(CartProductModel product);
  Future<CartModel> fetchCartProducts();

  Future<CartModel> removeCartItem(ProductModel prod);

  Future<void> placeOrder();
  Future<OrderModel> fetchAllOrders();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  CheckoutDataSourceImpl({
    required this.fireAuth,
    required this.fireCollections,
  });

  final FireAuth fireAuth;
  final FireCollections fireCollections;

  List<CartProductModel> _productsList = [];
  List<CartModel> _carts = [];
  // OrderModel? allOrders;

  double _amount = 0;

  @override
  Future<CartModel> addProductToCart(CartProductModel cartProduct) async {
    final CartModel cartModel;
    double total = 0;
    bool exists = false;
    for (var prod in _productsList) {
      if (prod.product.id == cartProduct.product.id) {
        exists = true;
        break;
      }
    }
    if (exists) {
      final existingValueIndex = _productsList
          .indexWhere((cp) => cp.product.id == cartProduct.product.id);

      final existingValue = _productsList[existingValueIndex];

      _productsList[existingValueIndex] = CartProductModel(
        product: existingValue.product,
        quantity: existingValue.quantity + cartProduct.quantity,
      );
      //* retotalling
      for (var cartItem in _productsList) {
        total += (cartItem.product.price * cartItem.quantity);
      }
      _amount = total;
      cartModel = CartModel(
          cId: DateTime.now().toString(),
          user: await fireAuth.getCurrentUserModel(),
          products: _productsList,
          amount: double.parse((_amount).toStringAsFixed(2)));
    } else {
      _productsList.add(cartProduct);

      for (var cartItem in _productsList) {
        total += (cartItem.product.price * cartItem.quantity);
      }

      _amount = total;

      cartModel = CartModel(
        cId: DateTime.now().toString(),
        user: await fireAuth.getCurrentUserModel(),
        products: _productsList,
        amount: double.parse(_amount.toStringAsFixed(2)),
      );
    }

    fireCollections.storeCartProducts(cartModel);
    return cartModel;
  }

  @override
  Future<CartModel> fetchCartProducts() async {
    final userId = await fireAuth.getCurrentUserId();

    if (_productsList.isNotEmpty) {
      final cart = CartModel(
        cId: "$userId-cartId",
        user: await fireAuth.getCurrentUserModel(), // userId
        products: _productsList,
        amount: _amount,
      );
      return cart;
    }

    final fireData = await fetchFromFirebase();
    return fireData;
  }

  Future<CartModel> fetchFromFirebase() async {
    final cartModel = await fireCollections.fetchCartItems();
    _productsList = cartModel.products;
    _amount = cartModel.amount;
    return cartModel;
  }

  @override
  Future<CartModel> removeCartItem(ProductModel prod) async {
    double total = 0;
    // final userId = await fireAuth.getCurrentUserId();

    _productsList.removeWhere((cartItem) => cartItem.product.id == prod.id);

    for (var cartItem in _productsList) {
      total += (cartItem.product.price * cartItem.quantity);
    }
    _amount = total;

    final cartModel = CartModel(
      user: await fireAuth.getCurrentUserModel(),
      products: _productsList,
      amount: double.parse(_amount.toStringAsFixed(2)),
    );

    fireCollections.removeItemFromCart(cartModel);
    return cartModel;
  }

  @override
  Future<void> placeOrder() async {
    final cartModel = CartModel(
        user: await fireAuth.getCurrentUserModel(),
        products: _productsList,
        amount: double.parse(_amount.toStringAsFixed(2)),
        cartStatus: CartStatus.orderPlaced);

    _carts.add(cartModel);

    // clear cart
    _productsList.clear();
    _amount = 0;
    await fireCollections.clearAllCartItems();

    return await fireCollections.cartToOrderCollection(_carts);
  }

  @override
  Future<OrderModel> fetchAllOrders() async {
    if (_carts.isNotEmpty) {
      final orderM = OrderModel(
        user: await fireAuth.getCurrentUserModel(),
        cartList: _carts,
      );

      return orderM;
    } else {
      final orderM = await fireCollections.fetchOrders();

      _carts = orderM.cartList;

      return orderM;
    }
  }
}
