import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/credit_card_model.dart';
import '../repository/payment_repository.dart';

class FetchCreditCardDetailsUsecase extends Usecase<CreditCardModel, NoParams> {
  final PaymentRepository repository;

  FetchCreditCardDetailsUsecase({required this.repository});
  @override
  Future<Either<Failure, CreditCardModel>> call(NoParams params) async {
    return await repository.fetchCreditCardDetails();
  }
}
