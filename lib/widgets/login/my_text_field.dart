// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    Key? key,
    required this.label,
    required this.prefixIcon,
    this.inputType = TextInputType.text,
    this.obscure = false,
  }) : super(key: key);

  final String label;
  final Icon prefixIcon;
  final TextInputType inputType;
  final bool obscure;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool isPasswordField;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.inputType == TextInputType.visiblePassword) {
      isPasswordField = true;
    } else {
      isPasswordField = false;
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
          obscureText: isPasswordField ? isVisible : false,
          onSaved: (newValue) {
            print(newValue);
          },
          validator: (value) {
            if (isPasswordField) {
              return null;
            }
            if (value == null || value.isEmpty) {
              return 'Enter an email';
            }
            if (!value.contains('@') || !value.contains('.com')) {
              return "Enter a valid email";
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            prefixIcon: widget.prefixIcon,
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
            hintText: widget.obscure ? 'xxxxxx' : "abc@asd.com",
          ),
        )
      ],
    );
  }
}
