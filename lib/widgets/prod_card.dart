// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/products.dart';

class ProdCard extends StatelessWidget {
  const ProdCard({
    Key? key,
    required this.imageUri,
  }) : super(key: key);

  final String imageUri;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              // image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  getImageUri(imageUri),
                  fit: BoxFit.fill,
                  width: 80,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              //info
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          productTittle,
                        ),
                        Text(
                          productCat,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      '\$212',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.more_horiz,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Color(0xff1B2028),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
