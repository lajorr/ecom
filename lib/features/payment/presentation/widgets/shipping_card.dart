import 'package:ecom/features/payment/presentation/widgets/add_cart_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../bloc/payment_bloc.dart';

class ShippingCard extends StatefulWidget {
  const ShippingCard({super.key});

  @override
  State<ShippingCard> createState() => _ShippingCardState();
}

class _ShippingCardState extends State<ShippingCard> {
  @override
  void initState() {
    super.initState();

    context.read<PaymentBloc>().add(FetchCreditCardInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Information',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentInfoAddSuccess) {
              context.read<PaymentBloc>().add(FetchCreditCardInfoEvent());
            }
          },
          builder: (context, state) {
            if (state is PaymentInfoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PaymentInfoFetchSuccess) {
              bool hasCreditInfo;

              final userCredit = state.creditM;
              if (userCredit.cardHolderName == null) {
                hasCreditInfo = false;
              } else {
                hasCreditInfo = true;
              }

              return Container(
                height: media.height * 0.09,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        hasCreditInfo
                            ? Row(
                                children: [
                                  // hasCreditInfo ?
                                  Image.asset(
                                    ImageConstants.getImageUri(
                                        ImageConstants.visaIcon),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(userCredit.cardNum!),
                                ],
                              )
                            : Row(
                                children: [
                                  // hasCreditInfo ?
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const AddCartInfoDialog(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Add Credit Card Info"),
                                ],
                              ),
                      ],
                    ),
                    if (hasCreditInfo)
                      const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 32,
                      )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("ELSE"),
              );
            }
          },
        )
      ],
    );
  }
}
