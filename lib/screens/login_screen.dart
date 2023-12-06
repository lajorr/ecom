import 'package:ecom/widgets/login/login_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To\n E-com',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 42,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            LoginCard(),
          ],
        ),
      ),
    );
  }
}
