import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/payment/data/data%20source/payment_datasource.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';
import 'package:ecom/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {

  PaymentRepositoryImpl({required this.dataSource});
  final PaymentDatasource dataSource;

  @override
  Future<Either<Failure, void>> addCreditCardDetails(
      CreditCardModel creditModel,) async {
    try {
      final res = await dataSource.storeCardInfo(creditModel: creditModel);
      return Right(res);
    } catch (e) {
      return const Left(DocumentFailure(message: 'credit store failed'));
    }
  }

  @override
  Future<Either<Failure, CreditCardModel>> fetchCreditCardDetails() async {
    try {
      final creditM = await dataSource.fetchCardInfo();
      return Right(creditM);
    } catch (e) {
      return const Left(
        DocumentFailure(
          message: 'card detail fetch failed',
        ),
      );
    }
  }
}
