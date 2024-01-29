import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';
import 'package:ecom/features/payment/domain/repository/payment_repository.dart';

class FetchCreditCardDetailsUsecase extends Usecase<CreditCardModel, NoParams> {
  final PaymentRepository repository;

  FetchCreditCardDetailsUsecase({required this.repository});
  @override
  Future<Either<Failure, CreditCardModel>> call(NoParams params) async {
    return await repository.fetchCreditCardDetails();
  }
}
