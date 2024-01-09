// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/entity/cart_product_entity.dart';
import 'package:ecom/features/checkout/domain/usecases/add_to_cart_usecase.dart';
import 'package:ecom/features/checkout/domain/usecases/fetch_cart_products_usecase.dart';
import 'package:equatable/equatable.dart';

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
    print('add to Cart event');

    final addOrFail = await addToCartUsecase.call(event.cartProduct);

    addOrFail.fold((failure) => emit(CheckoutAddFailed()), (_) {
      emit(CheckoutAddSuccess());
      print("SUCCESS");
    });
  }

  FutureOr<void> _onFetchCartProducts(
      FetchCartProductsEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    final fetchOrFail = await fetchCartProductsUsecase.call(NoParams());

    fetchOrFail.fold(
      (failure) => emit(CheckoutFailed()),
      (cartProdList) {
        print('FETCH SUCCESS');
        emit(
          CheckoutLoaded(
            cartProductList: cartProdList,
          ),
        );
        print(cartProdList);
      },
    );
  }
}
