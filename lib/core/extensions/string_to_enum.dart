import 'package:ecom/features/chat/domain/entity/message_enity.dart';

import '../../features/checkout/domain/entity/enums/cart_status_enum.dart';
import '../../shared/catalog/enitity/enum/category_enum.dart';

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

  Category toCategory() {
    switch (this) {
      case 'dress':
        return Category.dress;
      case 'tech':
        return Category.tech;
      case 'watch':
        return Category.watch;
      case 'all':
        return Category.all;
      default:
        return Category.all;
    }
  }

  MessageType toMessageType() {
    switch (this) {
      case 'photo':
        return MessageType.photo;
      case 'video':
        return MessageType.video;
      default:
        return MessageType.text;
    }
  }
}
