import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/common/widgets/my_shimmer.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/presentation/blocs/cubit/credit_card_set_cubit.dart';
import 'package:ecom/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:ecom/features/payment/presentation/widgets/add_cart_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingCard extends StatefulWidget {
  const ShippingCard({
    super.key,
  });

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
          StringConstants.shippingInfoText,
          style: TextStyle(
            fontSize: 16,
          ),
        ).tr(),
        BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentInfoAddSuccess) {
              context.read<PaymentBloc>().add(FetchCreditCardInfoEvent());
            }
          },
          builder: (context, state) {
            if (state is PaymentInfoLoading) {
              return MyShimmer(
                child: Container(
                  width: double.infinity,
                  height: media.height * 0.09,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
              context
                  .read<CreditCardSetCubit>()
                  .setCreditCardStatus(hasCreditInfo);

              return Container(
                height: media.height * 0.09,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (hasCreditInfo) Row(
                            children: [
                              Image.asset(
                                ImageConstants.getImageUri(
                                    ImageConstants.visaIcon,),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                userCredit.cardNum!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ) else Row(
                            children: [
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
                              const Text('Add Credit Card Info'),
                            ],
                          ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('ELSE'),
              );
            }
          },
        ),
      ],
    );
  }
}
