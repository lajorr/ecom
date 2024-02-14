part of 'credit_card_set_cubit.dart';

sealed class CreditCardSetState extends Equatable {
  const CreditCardSetState();
}

final class CreditCardSetFalse extends CreditCardSetState {
  const CreditCardSetFalse({required this.hasCredit});
  final bool hasCredit;

  @override
  List<Object?> get props => [hasCredit];
}

final class CreditCardSetTrue extends CreditCardSetState {
  const CreditCardSetTrue({required this.hasCredit});
  final bool hasCredit;

  @override
  List<Object?> get props => [hasCredit];
}
