import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> addCreditCardDetails(
      CreditCardModel creditModel,);
  Future<Either<Failure, CreditCardModel>> fetchCreditCardDetails();
}
