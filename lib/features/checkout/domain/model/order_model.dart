import '../entity/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({required super.user, required super.cartList});
  @override
  List<Object?> get props => [
        user,
        cartList,
      ];

  // factory OrderModel.fromJson(Map<String, dynamic> map) {
  //   return OrderModel(
  //     user: (map['user'] as DocumentReference<Map<String, dynamic>>),
  //     cartList: (map['carts']),
  //   );
  // }
}
