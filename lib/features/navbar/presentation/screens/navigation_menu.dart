import 'package:ecom/common/widgets/my_drawer.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/features/catalog/presentation/screens/catalog_screen.dart';
import 'package:ecom/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:ecom/features/favorites/presentation/screens/fav_screen.dart';
import 'package:ecom/features/navbar/presentation/cubit/nav_index_cubit.dart';
import 'package:ecom/features/navbar/presentation/widgets/nav_item.dart';
import 'package:ecom/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  static const routeName = '/navigation-menu';

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const CatalogScreen(),
      const CheckoutScreen(),
      const FavScreen(),
      const ProfileScreen(),
    ];

    final navIcons = <String>[
      ImageConstants.homeIcon,
      ImageConstants.shopBagIcon,
      ImageConstants.heartIcon,
      ImageConstants.profileIcon,
    ];
    return BlocConsumer<NavIndexCubit, NavIndexState>(
      listener: (context, state) {
        if (state is NavIndexChanged) {
          context.read<NavIndexCubit>().onSetCurrentIndex(state.index);
        }
      },
      builder: (context, state) {
        if (state is NavIndexCurrent) {
          final selectedIndex = state.index;
          return Scaffold(
            drawerEnableOpenDragGesture: false,
            drawer: MyDrawer(
              ctx: context,
            ),
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
                    NavItem(
                      iconUri: navIcons[i],
                      bgColor: i == selectedIndex
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.secondary,
                      onTap: () {
                        context.read<NavIndexCubit>().onChangeNavIndex(i);
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
