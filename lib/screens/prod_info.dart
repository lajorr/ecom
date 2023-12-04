// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';

class ProdInfo extends StatelessWidget {
  const ProdInfo({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  child: const Icon(
                    Icons.remove,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '1',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            )
          ],
        ),
        // rating
        Row(
          children: [
            SizedBox(
              // width: 200,
              width: 160,
              height: 30,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      getImageUri(starIcon),
                    ),
                  );
                },
              ),
            ),
            RichText(
              text: const TextSpan(
                text: '5 ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '(123123)',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        // details
        RichText(
          text: const TextSpan(
            text: '''Its simple and elegant shape makes it perfect for
those of you who like you who want minimalist
clothes ''',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Read More. . .',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
        )
      ],
    );
  }
}
