import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/credit_card_entity.dart';

class CreditCardModel extends CreditCardEntity {
  const CreditCardModel({
    required super.cardNum,
    required super.cardHolderName,
    required super.cvv,
    required super.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'card_number': cardNum,
      'card_holder': cardHolderName,
      'cvv': cvv,
      'expiry_date': expiryDate,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    final date = (map['expiry_date'] as Timestamp).toDate().toString();
    return CreditCardModel(
      cardNum: map['card_number'],
      cardHolderName: map['card_holder'],
      cvv: map['cvv'],
      expiryDate: DateTime.tryParse(date),
    );
  }

  CreditCardModel copyWith({
    String? cardNum,
    String? cardHolderName,
    int? cvv,
    DateTime? expiryDate,
  }) {
    return CreditCardModel(
      cardNum: cardNum ?? this.cardNum,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cvv: cvv ?? this.cvv,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
