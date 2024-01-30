// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/map/presentation/screens/show_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    Key? key,
    required this.ctx,
  }) : super(key: key);

  final BuildContext ctx;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
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
                Navigator.of(context).pushNamed(ShowMapScreen.routeName);
              },
              child: const Text("Pick Location"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.ctx.read<OrdersBloc>().add(OrderCartItemsEvent());
              Navigator.of(widget.ctx).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    });
  }
}
