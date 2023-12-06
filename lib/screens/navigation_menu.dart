import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/screens/fav_screen.dart';
import 'package:ecom/screens/home_screen.dart';
import 'package:ecom/screens/profile_screen.dart';
import 'package:ecom/widgets/nav_item.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int selectedIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const FavScreen(),
    const ProfileScreen(),
  ];

  List<String> navIcons = [homeIcon, shopBagIcon, heartIcon, profileIcon];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
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
            for (int i = 0; i < navIcons.length; i++) ...[
              // select vako dekhauna lai if i == selectedIndex ? bgColor : ... : .... garda hunxa hola
              NavItem(
                iconUri: navIcons[i],
                onTap: () {
                  setState(() {
                    if (i == 0) {
                      selectedIndex = i;
                    }
                    if (i >= 2) {
                      selectedIndex = i - 1;
                    }
                  });
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
