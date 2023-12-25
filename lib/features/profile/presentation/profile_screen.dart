import '../../../common/widgets/custom_appbar.dart';
import '../../../constants/string_constants.dart';
import '../../../core/firebaseFunctions/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    User currentUser = FireAuth().currentUser!;

    String email = currentUser.email!;

    Future<void> logOut() async {
      await FireAuth().signOut();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CustomAppbar(
                title: StringConstants.profileText,
                actions: false,
                backButton: false,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(email),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: logOut,
                child: const Text(
                  StringConstants.logOutText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
