import 'package:ecom/services/auth.dart';
import 'package:ecom/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User currentUser = Auth().currentUser!;

    String email = currentUser.email!;

    Future<void> logOut() async{
      await Auth().signOut();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CustomAppbar(
                title: 'Profile',
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
                  'Log Out',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
