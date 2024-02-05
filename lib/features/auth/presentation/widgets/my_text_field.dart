// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecom/constants/string_constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key? key,
    required this.label,
    this.errorMsg,
    required this.prefixIcon,
    this.inputType = TextInputType.text,
    this.obscure = false,
    this.hintText,
    required this.onFieldSave,
    this.validator,
  }) : super(key: key);

  final String label;
  final String? errorMsg;
  final Icon prefixIcon;
  final TextInputType inputType;
  final bool? obscure;
  final String? hintText;
  final Function(String?) onFieldSave;

  final String? Function(String?)? validator;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isPasswordField = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    if (widget.inputType == TextInputType.visiblePassword) {
      isPasswordField = true;
      isVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //label
        Text(widget.label),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: widget.inputType,
          obscureText: isVisible,
          onSaved: (newValue) => widget.onFieldSave(newValue),
          validator: widget.validator ??
              (value) {
                if (isPasswordField) {
                  return null;
                }
                if (value == null || value.isEmpty) {
                  return StringConstants.emailErrorMsg1;
                }
                if (!value.contains('@') || !value.contains('.com')) {
                  return StringConstants.emailErrorMsg2;
                }
                return null;
              },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            prefixIcon: widget.prefixIcon,
            errorText: widget.errorMsg, //
            suffixIcon: isPasswordField
                ? IconButton(
                    icon: Icon(
                      !isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          isVisible = !isVisible;
                        },
                      );
                    },
                  )
                : null,
            border: const OutlineInputBorder(),
            hintText: widget.hintText,
          ),
        )
      ],
    );
  }
}
