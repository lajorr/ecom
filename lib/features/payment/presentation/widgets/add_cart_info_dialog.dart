import 'package:ecom/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/model/credit_card_model.dart';
import '../bloc/payment_bloc.dart';

class AddCartInfoDialog extends StatefulWidget {
  const AddCartInfoDialog({super.key});

  @override
  State<AddCartInfoDialog> createState() => _AddCartInfoDialogState();
}

class _AddCartInfoDialogState extends State<AddCartInfoDialog> {
  final _formKey = GlobalKey<FormState>();

  String cardHolderName = '';
  String cardNumber = '';
  String cvv = '';
  String expDate = '';

  void onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final expDateTime = DateFormat('yM').parse(expDate);

      final creditM = CreditCardModel(
        cardNum: cardNumber,
        cardHolderName: cardHolderName,
        cvv: int.parse(cvv),
        expiryDate: expDateTime,
      );

      context.read<PaymentBloc>().add(
            AddPaymentDetailsEvent(
              creditCardModel: creditM,
            ),
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Card Info'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                label: 'Card Holder',
                prefixIcon: const Icon(Icons.credit_score),
                onFieldSave: (value) {
                  cardHolderName = value!;
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter a name";
                  }
                  return null;
                },
              ),
              MyTextField(
                label: 'Card Number',
                prefixIcon: const Icon(Icons.credit_card),
                onFieldSave: (value) {
                  cardNumber = value!;
                },
                inputType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter your card Number";
                  }
                  if (value!.length != 16) {
                    return "Enter Valid Card Number";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      label: 'CVV',
                      prefixIcon: const Icon(Icons.credit_score),
                      onFieldSave: (value) {
                        cvv = value!;
                      },
                      hintText: '123',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter cvv";
                        }
                        if (value!.length != 3) {
                          return "Enter Valid CVV";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyTextField(
                      label: 'Expiry Date',
                      prefixIcon: const Icon(Icons.credit_score),
                      inputType: TextInputType.datetime,
                      onFieldSave: (value) {
                        expDate = value!;
                      },
                      hintText: 'mm/dd',
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter date";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text(
            "Confirm",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
