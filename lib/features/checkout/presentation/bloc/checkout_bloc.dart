// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/domain/usecases/add_to_cart_usecase.dart';

import 'package:ecom/features/checkout/domain/usecases/fetch_cart_products_usecase.dart';
import 'package:ecom/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:ecom/features/checkout/domain/usecases/remove_cart_item_usecase.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/model/cart_product_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required this.addToCartUsecase,
    required this.fetchCartProductsUsecase,
    required this.removeCartItemUsecase,
    required this.placeOrderUsecase,
  }) : super(CheckoutInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<FetchCartProductsEvent>(_onFetchCartProducts);
    on<PayForCartEvent>(_onPayForCartEvent);
    on<RemoveProdFromCartEvent>(_onRemoveProdFromCart);
  }

  final AddToCartUsecase addToCartUsecase;
  final FetchCartProductsUsecase fetchCartProductsUsecase;

  final RemoveCartItemUsecase removeCartItemUsecase;
  final PlaceOrderUsecase placeOrderUsecase;

  FutureOr<void> _onAddToCart(
      AddToCartEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutInitial());
    final addOrFail = await addToCartUsecase.call(event.cartProduct);

    addOrFail.fold(
      (failure) => emit(CheckoutAddFailed()),
      (_) {
        // emit(CheckoutAddSuccess());
        emit(
          CheckoutLoaded(
            cartModel: _,
          ),
        );
      },
    );
  }

  FutureOr<void> _onFetchCartProducts(
      FetchCartProductsEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    final fetchOrFail = await fetchCartProductsUsecase.call(NoParams());

    fetchOrFail.fold(
      (failure) => emit(CheckoutFetchFailed()),
      (cartModel) {
        emit(
          CheckoutLoaded(
            cartModel: cartModel,
          ),
        );
      },
    );
  }

  FutureOr<void> _onPayForCartEvent(
      PayForCartEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    // final payOrFail = await clearCartItemsUsecase.call(NoParams());
    // payOrFail.fold((failure) => emit(CheckoutPaymentFailed()), (_) {
    //   emit(CheckoutPaymentSuccess());
    // });
    final payOrFail = await placeOrderUsecase.call(NoParams());
    payOrFail.fold((failure) => emit(CheckoutPaymentFailed()), (_) {
      emit(
        CheckoutPaymentSuccess(),
      );
    });
  }

  FutureOr<void> _onRemoveProdFromCart(
      RemoveProdFromCartEvent event, Emitter<CheckoutState> emit) async {
    final removeOrFail = await removeCartItemUsecase.call(event.prod);

    removeOrFail.fold((failure) => emit(CheckoutRemoveItemFailed()),
        (cartModel) {
      emit(CheckoutLoaded(
        cartModel: cartModel,
      ));
    });
  }
}
