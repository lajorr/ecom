import 'package:ecom/features/auth/presentation/widgets/my_text_field.dart';
import 'package:ecom/features/payment/data/model/credit_card_model.dart';
import 'package:ecom/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  String expDate = '___';

  void onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final expDateTime = DateFormat('yMd').parse(expDate);
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
                hintText: 'John Doe',
                prefixIcon: const Icon(Icons.credit_score),
                onFieldSave: (value) {
                  cardHolderName = value!;
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter a name';
                  }
                  return null;
                },
              ),
              MyTextField(
                label: 'Card Number',
                hintText: '1234567891011321',
                prefixIcon: const Icon(Icons.credit_card),
                onFieldSave: (value) {
                  cardNumber = value!;
                },
                inputType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter your card Number';
                  }
                  if (value!.length != 16) {
                    return 'Enter Valid Card Number';
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
                          return 'Enter cvv';
                        }
                        if (value!.length != 3) {
                          return 'Enter Valid CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  //* Date Picker
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Expiry Date'),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2003),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                expDate = DateFormat('yMd').format(pickedDate);
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                expDate,
                              ),
                            ),
                          ),
                        ),
                      ],
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
            'Confirm',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
