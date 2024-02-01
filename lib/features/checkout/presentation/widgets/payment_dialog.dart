// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/checkout/domain/entity/enums/cart_status_enum.dart';
import 'package:ecom/features/checkout/domain/model/cart_model.dart';
import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/map/presentation/screens/show_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    Key? key,
    required this.ctx,
    required this.cartModel,
  }) : super(key: key);

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
    return Builder(builder: (context) {
      return AlertDialog(
        title: const Text("Confirm Payment"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ShowMapScreen.routeName,
                    arguments: {'onConfirmPos': onConfirmPos});
              },
              child: const Text("Pick Location"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
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
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    });
  }
}
