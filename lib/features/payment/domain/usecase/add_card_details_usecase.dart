import 'package:dartz/dartz.dart';

import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';
import 'package:ecom/features/payment/domain/repository/payment_repository.dart';

class AddCardDetailsUsecase extends Usecase<void, CreditCardModel> {
  AddCardDetailsUsecase({required this.repository});
  final PaymentRepository repository;

  @override
  Future<Either<Failure, void>> call(CreditCardModel params) async {
    return await repository.addCreditCardDetails(params);
  }
}
