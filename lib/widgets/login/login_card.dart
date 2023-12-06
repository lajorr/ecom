import 'package:ecom/widgets/login/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void onFormSave() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
      }
    }

    return Container(
      // height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const MyTextField(
              label: "Email",
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
              ),
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            const MyTextField(
              label: "Password",
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              inputType: TextInputType.visiblePassword,
              obscure: true,
            ),
            const SizedBox(
              height: 20,
            ),

            // forgot? login btn
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
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
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            TextButton(
              onPressed: () {},
              child: const Text(
                'No Account? Sign Up',
                style: TextStyle(
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
