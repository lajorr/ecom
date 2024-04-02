import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/credit_card_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> addCreditCardDetails(
      CreditCardModel creditModel);
  Future<Either<Failure, CreditCardModel>> fetchCreditCardDetails();
}
