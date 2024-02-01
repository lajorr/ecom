import '../../../auth/data/model/user_model.dart';
import '../entity/cart_entity.dart';
import '../entity/enums/cart_status_enum.dart';
import 'cart_product_model.dart';

class CartModel extends CartEntity {
  const CartModel({
    super.cId,
    required super.user,
    required super.products,
    required super.amount,
    super.cartStatus = CartStatus.cartCreated,
    super.lat,
    super.lng,
  });

  @override
  String toString() {
    return "cid:$cId, user:${user.name}, products:${products.length}, amount: $amount , status: ${cartStatus.name}, lat:$lat , lng:$lng";
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'user': user.toMap(),
      'products': products
          .map(
            (prod) => prod.toMap(),
          )
          .toList(),
      'status': cartStatus.name,
      'lat': lat,
      'lng': lng,
    };
  }

  CartModel copyWith({
    UserModel? user,
    List<CartProductModel>? products,
    double? amount,
    CartStatus? cartStatus,
    double? lat,
    double? lng,
  }) {
    return CartModel(
      user: user ?? this.user,
      products: products ?? this.products,
      amount: amount ?? this.amount,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object?> get props => [cId, user, products, amount, lat, lng];
}
