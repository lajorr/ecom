import 'package:ecom/common/widgets/my_snackbar.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/data/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_text_field.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final formKey = GlobalKey<FormState>();

  bool onSignUp = false;

  String email = '';
  String password = '';

  Future<void> onFormSave() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        if (onSignUp) {
          await Auth().createUser(email: email, password: password);
        } else {
          await Auth().signIn(email: email, password: password);
        }
      } on FirebaseAuthException catch (e) {
        debugPrint('error: $e');
        if (context.mounted) {
          MySnackbar(
            context: context,
            message: e.message.toString(),
            snackType: SnackBarType.error,
          ).show();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              onSignUp ? StringConstants.signupText : StringConstants.loginText,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            MyTextField(
              label: StringConstants.emailLabel,
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
              ),
              inputType: TextInputType.emailAddress,
              onFieldSave: (value) {
                email = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              label: StringConstants.passwordLabel,
              prefixIcon: const Icon(
                Icons.vpn_key,
              ),
              inputType: TextInputType.visiblePassword,
              obscure: true,
              onFieldSave: (value) {
                password = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),

            // forgot? login btn
            Row(
              mainAxisAlignment: onSignUp
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (!onSignUp)
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      StringConstants.forgotPasswordText,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: const Color(0xff292526),
                  ),
                  onPressed: onFormSave,
                  child: Text(
                    onSignUp
                        ? StringConstants.signupText
                        : StringConstants.loginText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // login from google
            // Container(
            //   height: 50,
            //   margin: const EdgeInsets.symmetric(
            //     vertical: 20,
            //   ),
            //   color: Colors.grey[300],
            //   child: const Center(
            //     child: Text('Login from google'),
            //   ),
            // ),

            TextButton(
              onPressed: () {
                setState(() {
                  onSignUp = !onSignUp;
                });
              },
              child: Text(
                onSignUp
                    ? StringConstants.haveAnAccountText
                    : StringConstants.noAccountText,
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
