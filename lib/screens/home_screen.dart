import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/widgets/category_tile.dart';
import 'package:ecom/widgets/home_header.dart';
import 'package:ecom/widgets/my_grid_view.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    currentPage = 0;

    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 215, 215, 215),
      ),
      borderRadius: BorderRadius.circular(15),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              //header
              const Header(),
              // search Box
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          prefixIcon: Image.asset(
                            getImageUri(searchIcon),
                          ),
                          // prefix:
                          hintText: "Search Clothes",

                          // hintStyle: ,
                          enabledBorder: outlinedBorder,
                          focusedBorder: outlinedBorder,
                          border: outlinedBorder,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //filter
                    Container(
                      height: 50,
                      width: 50,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        getImageUri(
                          filterIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //category
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryTile(
                      iconUri: allCategory,
                      title: "All Items",
                    ),
                    CategoryTile(
                      iconUri: dressIcon,
                      title: "Dress",
                      isActive: true,
                    ),
                    CategoryTile(
                      iconUri: hatIcon,
                      title: "Hat",
                    ),
                    CategoryTile(
                      iconUri: watchIcon,
                      title: "Watch",
                    ),
                  ],
                ),
              ),

              // grid
              const Expanded(
                child: MyGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
