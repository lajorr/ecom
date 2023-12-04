// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({
    Key? key,
    required this.imageUri,
  }) : super(key: key);

  final String imageUri;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment,
      children: [
        //image
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            getImageUri(imageUri),
          ),
        ),

        const SizedBox(
          height: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            const Text(
              'Modern light clothes',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            //vcategory
            Text(
              'Dress modern',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //price
                Text("\$233"),
                Row(
                  children: [
                    Image.asset(
                      getImageUri(starIcon),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('5.0'),
                    SizedBox( 
                      width: 15,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
