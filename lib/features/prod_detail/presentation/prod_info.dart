// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';

class ProdInfo extends StatelessWidget {
  const ProdInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                product.prodTitle,
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
              width: media.width * 0.35,
              height: media.height * 0.03,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: product.rating.round(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Image.asset(
                    ImageConstants.getImageUri(ImageConstants.starIcon),
                  );
                },
              ),
            ),
            RichText(
              text: TextSpan(
                text: '${product.rating} ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "(${product.viewsNo})",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: media.height * 0.01,
        ),
        // details

        Text(
          product.prodDescription,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        )

        // RichText(
        //   text: TextSpan(
        //     text: product.prodDescription,
        //     style: const TextStyle(
        //       fontSize: 16,
        //       color: Colors.grey,
        //     ),
        //     children: const <TextSpan>[
        //       TextSpan(
        //         text: StringConstants.readMoreText,
        //         style: TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
