import '../../../../core/error/exception.dart';
import '../../../../core/firebaseFunctions/firebase_auth.dart';
import '../../../../core/firebaseFunctions/firebase_collections.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/cart_product_model.dart';
import '../../domain/model/order_model.dart';

abstract class CheckoutDataSource {
  Future<CartModel> addProductToCart(CartProductModel product);
  Future<CartModel> fetchCartProducts();

  Future<CartModel> removeCartItem(ProductModel prod);

  Future<void> placeOrder(CartModel cartM);
  Future<OrderModel> fetchAllOrders();
}

List<CartProductModel> _productsList = [];
List<CartModel> _carts = [];

double _amount = 0;

void clearData() {
  _productsList = [];
  _carts = [];
  _amount = 0;
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  CheckoutDataSourceImpl({
    required this.fireAuth,
    required this.fireCollections,
  });

  final FireAuth fireAuth;
  final FireCollections fireCollections;

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
      final user = await fireAuth.getCurrentUserModel();
      cartModel = CartModel(
          user: user!,
          products: _productsList,
          amount: double.parse((_amount).toStringAsFixed(2)));
    } else {
      _productsList.add(cartProduct);

      for (var cartItem in _productsList) {
        total += (cartItem.product.price * cartItem.quantity);
      }

      _amount = total;
      final user = await fireAuth.getCurrentUserModel();
      cartModel = CartModel(
        cId: DateTime.now().toString(),
        user: user!,
        products: _productsList,
        amount: double.parse(_amount.toStringAsFixed(2)),
      );
    }

    await fireCollections.storeCartProducts(cartModel);
    return cartModel;
  }

  @override
  Future<CartModel> fetchCartProducts() async {
    final user = await fireAuth.getCurrentUserModel();
    if (_productsList.isNotEmpty) {
      final cart = CartModel(
        user: user!,
        products: _productsList,
        amount: double.parse(_amount.toStringAsFixed(2)),
      );
      return cart;
    } else {
      final fireData = await fetchFromFirebase();
      return fireData;
    }
  }

  Future<CartModel> fetchFromFirebase() async {
    final cartModel = await fireCollections.fetchCartItems();
    _productsList = cartModel.products;

    _amount = double.parse(cartModel.amount.toStringAsFixed(2));
    return cartModel;
  }

  @override
  Future<CartModel> removeCartItem(ProductModel prod) async {
    try {
      double total = 0;

      _productsList.removeWhere((cartItem) => cartItem.product.id == prod.id);

      for (var cartItem in _productsList) {
        total += (cartItem.product.price * cartItem.quantity);
      }
      _amount = total;
      final user = await fireAuth.getCurrentUserModel();
      final cartModel = CartModel(
        user: user!,
        products: _productsList,
        amount: double.parse(
          _amount.toStringAsFixed(2),
        ),
      );

      await fireCollections.removeItemFromCart(cartModel);

      return cartModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> placeOrder(CartModel cartM) async {
    if (_productsList.isEmpty) {
      throw EmptyCartException();
    }

    _carts.add(cartM);

    await fireCollections.cartToOrderCollection(_carts);

    _productsList = [];
    _amount = 0;

    await fireCollections.clearAllCartItems();
  }

  @override
  Future<OrderModel> fetchAllOrders() async {
    if (_carts.isNotEmpty) {
      final user = await fireAuth.getCurrentUserModel();
      final orderM = OrderModel(
        user: user!,
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
