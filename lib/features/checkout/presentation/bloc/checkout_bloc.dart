import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<AddToCartEvent>(_onAddToCart);
  }

  FutureOr<void> _onAddToCart(
      AddToCartEvent event, Emitter<CheckoutState> emit) {
    print('add to Cart event');
  }
}
