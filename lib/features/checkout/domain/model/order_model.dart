import 'package:ecom/features/checkout/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({required super.user, required super.cartList});
  @override
  List<Object?> get props => [
        user,
        cartList,
      ];
}
