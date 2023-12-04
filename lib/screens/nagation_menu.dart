import 'dart:io';

import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  // List<Widget> pages = [
  //   const HomeScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          bottom: 15,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(255, 65, 60, 61),
              child: Image.asset(
                getImageUri(homeIcon),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(255, 65, 60, 61),
              child: Image.asset(
                getImageUri(shopBagIcon),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(255, 65, 60, 61),
              child: Image.asset(
                getImageUri(heartIcon),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(255, 65, 60, 61),
              child: Image.asset(
                getImageUri(profileIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
