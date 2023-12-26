import 'package:flutter/material.dart';

import '../../../constants/img_uri.dart';
import '../../catalog/presentation/screens/catalog_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import 'nav_item.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  static const routeName = '/navigation-menu';

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int selectedIndex = 0;

  List<Widget> pages = [
    const CatalogScreen(),
    // const FavScreen(),
    const ProfileScreen(),
  ];

  List<String> navIcons = [
    ImageConstants.homeIcon,
    ImageConstants.shopBagIcon,
    ImageConstants.heartIcon,
    ImageConstants.profileIcon
  ];

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
                    if (i == 3) {
                      selectedIndex = 1;
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
