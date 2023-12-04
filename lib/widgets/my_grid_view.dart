import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/widgets/my_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      image1,
      image2,
      image3,
      image4,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 4,
        itemCount: 4,
        itemBuilder: (context, index) {
          return MyGridTile(
            imageUri: imageList[index],
          );
        },
      ),
    );
  }
}
