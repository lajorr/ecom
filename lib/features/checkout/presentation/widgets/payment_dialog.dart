// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/checkout/presentation/screens/show_map_screen.dart';
import 'package:flutter/material.dart';

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
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Pick Location"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // widget.ctx.read<OrdersBloc>().add(OrderCartItemsEvent());
              // Navigator.of(widget.ctx).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ShowMapScreen(),
              ));
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    });
  }
}
