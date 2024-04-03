import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import 'package:ecom/features/checkout/presentation/blocs/cubit/credit_card_set_cubit.dart';
import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/checkout/presentation/widgets/cart_bill_widget.dart';
import 'package:ecom/features/checkout/presentation/widgets/cart_products_widget.dart';
import 'package:ecom/features/checkout/presentation/widgets/payment_dialog.dart';
import 'package:ecom/features/checkout/presentation/widgets/shimmer/checkout_shimmer.dart';
import 'package:ecom/features/payment/presentation/widgets/shipping_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
  });

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    const shippingFee = 0.00;
    final media = MediaQuery.of(context).size;

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is OrderPaymentSuccess) {
          context.read<CheckoutBloc>().add(FetchCartProductsEvent());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state is OrderPaymentFailed) {
          context.read<OrdersBloc>().add(FetchOrderHistoryEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutAddSuccess) {
            context.read<CheckoutBloc>().add(FetchCartProductsEvent());
          }

          if (state is CheckoutRemoveItemSuccess) {
            context.read<CheckoutBloc>().add(
                  FetchCartProductsEvent(),
                );
          }
        },
        builder: (ctx, state) {
          if (state is CheckoutLoading) {
            return Scaffold(
              body: CheckoutShimmer(media: media),
            );
          } else if (state is CheckoutFetchFailed) {
            return const Scaffold(
              body: Center(
                child: Text(StringConstants.dataFetchErrorText),
              ),
            );
          } else if (state is CheckoutLoaded) {
            final cart = state.cartModel;

            final productList = cart.products;

            final totalAmt = shippingFee + cart.amount;

            return Scaffold(
              extendBody: true,
              appBar: AppBar(
                title: const Text(StringConstants.checkoutText).tr(),
                backgroundColor: Colors.transparent,
                actions: [
                  BlocBuilder<CreditCardSetCubit, CreditCardSetState>(
                    builder: (context, state) {
                      if (state is CreditCardSetTrue) {
                        return TextButton(
                          onPressed: () {
                            showDialog(
                              context: ctx,
                              builder: (ctx) =>
                                  PaymentDialog(ctx: ctx, cartModel: cart),
                            );
                          },
                          child: const Text(StringConstants.payText).tr(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // prod list
                    if (productList.isEmpty)
                      SizedBox(
                        height: media.height * 0.25,
                        child: Column(
                          children: [
                            Image.asset(
                              ImageConstants.getImageUri(
                                  ImageConstants.emptyCartIcon,),
                              height: media.height * 0.1,
                            ),
                            SizedBox(
                              height: media.height * 0.03,
                            ),
                            const Text(
                              StringConstants.noProductText,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ).tr(),
                          ],
                        ),
                      )
                    else
                      CartProductsWidget(
                        cart: cart,
                      ),

                    SizedBox(
                      height: media.height * 0.02,
                    ),

                    //shipping info
                    const ShippingCard(),

                    // total amount
                    CartBillWidget(
                      productList: productList,
                      cart: cart,
                      shippingFee: shippingFee,
                      totalAmt: totalAmt,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('ELSe'),
            );
          }
        },
      ),
    );
  }
}
