import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  const CreditCardEntity({
    required this.cardNum,
    required this.cardHolderName,
    required this.cvv,
    required this.expiryDate,
  });

  final String? cardNum;
  final String? cardHolderName;
  final int? cvv;
  final DateTime? expiryDate;

  @override
  List<Object?> get props => [
        cardNum,
        cardHolderName,
        cvv,
        expiryDate,
      ];
}
