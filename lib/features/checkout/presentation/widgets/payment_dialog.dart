import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/map/presentation/screens/show_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    required this.ctx, required this.cartModel, super.key,
  });

  final BuildContext ctx;
  final CartModel cartModel;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  LatLng? markerLatlng;
  void onConfirmPos(LatLng pickedLatlng) {
    markerLatlng = pickedLatlng;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(StringConstants.confirmPayText).tr(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ShowMapScreen.routeName,
                  arguments: {'onConfirmPos': onConfirmPos},);
            },
            child: const Text(StringConstants.pickLocationText).tr(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (markerLatlng != null) {
              final lat = markerLatlng!.latitude;
              final lng = markerLatlng!.longitude;

              final cartWLat = widget.cartModel.copyWith(
                lat: lat,
                lng: lng,
                cartStatus: CartStatus.orderPlaced,
              );

              widget.ctx.read<OrdersBloc>().add(
                    OrderCartItemsEvent(cartModel: cartWLat),
                  );
              Navigator.of(widget.ctx).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please Choose a delivery location..'),
                  backgroundColor: Colors.red,
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          },
          child: const Text(StringConstants.okText).tr(),
        ),
      ],
    );
  }
}
