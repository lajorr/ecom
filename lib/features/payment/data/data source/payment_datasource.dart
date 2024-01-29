import 'package:ecom/core/firebaseFunctions/firebase_collections.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';

abstract class PaymentDatasource {
  Future<void> storeCardInfo({required CreditCardModel creditModel});
  Future<CreditCardModel> fetchCardInfo();
}

class PaymentDatasourceImpl implements PaymentDatasource {
  PaymentDatasourceImpl({required this.fireCollections});
  final FireCollections fireCollections;
  @override
  Future<void> storeCardInfo({required CreditCardModel creditModel}) async {
    return await fireCollections.storeCardInfo(creditModel);
  }

  @override
  Future<CreditCardModel> fetchCardInfo() async {
    final creditM = await fireCollections.fetchCreditCardInfo();

    String formattedNum = '';
    String cardNum = creditM.cardNum!;

    // to add space
    for (var i = 0; i < cardNum.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedNum += " ";
      }
      // to hide the string
      if (i < 12) {
        formattedNum += '*';
      } else {
        formattedNum += cardNum[i];
      }
    }

    final formattedCredit = creditM.copyWith(cardNum: formattedNum);
    return formattedCredit;
  }
}
