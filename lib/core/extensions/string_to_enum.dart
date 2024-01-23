import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';

extension ToEnum on String {
  CartStatus toCartStatus() {
    switch (this) {
      case 'cartCreated':
        return CartStatus.cartCreated;
      case 'orderPlaced':
        return CartStatus.orderPlaced;
      default:
        return CartStatus.cartCreated;
    }
  }
}
