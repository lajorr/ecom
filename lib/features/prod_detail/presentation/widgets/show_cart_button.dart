import 'package:ecom/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';

class ShowCartButton extends StatelessWidget {
  const ShowCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(CheckoutScreen.routeName);

        print("fetching ....");
        context.read<CheckoutBloc>().add(FetchCartProductsEvent());
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff292526),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          ImageConstants.getImageUri(ImageConstants.shopCart),
        ),
      ),
    );
  }
}
