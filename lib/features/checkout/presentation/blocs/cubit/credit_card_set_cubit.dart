import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credit_card_set_state.dart';

class CreditCardSetCubit extends Cubit<CreditCardSetState> {
  CreditCardSetCubit() : super(const CreditCardSetFalse(hasCredit: false));

  Future<void> setCreditCardStatus(bool hasCredit) async {
    if (hasCredit) {
      emit(CreditCardSetTrue(hasCredit: hasCredit));
    } else {
      emit(CreditCardSetFalse(hasCredit: hasCredit));
    }
  }
}
