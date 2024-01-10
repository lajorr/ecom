// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/usecases/add_to_cart_usecase.dart';
import 'package:ecom/features/checkout/domain/usecases/fetch_cart_products_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/model/cart_product_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required this.addToCartUsecase,
    required this.fetchCartProductsUsecase,
  }) : super(CheckoutInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<FetchCartProductsEvent>(_onFetchCartProducts);
  }

  final AddToCartUsecase addToCartUsecase;
  final FetchCartProductsUsecase fetchCartProductsUsecase;

  FutureOr<void> _onAddToCart(
      AddToCartEvent event, Emitter<CheckoutState> emit) async {
    

    final addOrFail = await addToCartUsecase.call(event.cartProduct);

    addOrFail.fold((failure) => emit(CheckoutAddFailed()), (_) {
      emit(CheckoutAddSuccess());
      
    });
  }

  FutureOr<void> _onFetchCartProducts(
      FetchCartProductsEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    final fetchOrFail = await fetchCartProductsUsecase.call(NoParams());

    fetchOrFail.fold(
      (failure) => emit(CheckoutFailed()),
      (cartModel) {
        
        emit(
          CheckoutLoaded(
            cartModel: cartModel,
          ),
        );
        
      },
    );
  }
}
