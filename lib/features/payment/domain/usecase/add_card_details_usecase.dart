import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/credit_card_model.dart';
import '../repository/payment_repository.dart';

class AddCardDetailsUsecase extends Usecase<void, CreditCardModel> {
  AddCardDetailsUsecase({required this.repository});
  final PaymentRepository repository;

  @override
  Future<Either<Failure, void>> call(CreditCardModel params) async {
    return await repository.addCreditCardDetails(params);
  }
}
