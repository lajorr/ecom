// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/shared/product/model/product_global_model.dart' as p;

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key? key,
    required this.product,
  }) : super(key: key);

  final p.Product product;

  @override
  Widget build(BuildContext context) {
    List<String> sizeList = [
      'S',
      'M',
      'L',
      'XL',
    ];

    // List<Color> colorList = const [
    //   Color.fromRGBO(27, 32, 40, 0.3),
    //   Color(0xff1B2028),
    //   Color(0xff292526),
    // ];

   

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringConstants.chooseSizeText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Container(
                        // height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          sizeList[index],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringConstants.colorText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: product.listSizeColor?.length ?? 0 ,
                  itemBuilder: (context, index) {
                    print(product.listSizeColor?.first.color.colorCode);
                    final color = product.listSizeColor![index].color.colorCode;
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Container(
                        // height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          // border: Border.all(
                          //   color: Colors.grey.shade300,
                          // ),
                          borderRadius: BorderRadius.circular(20),
                          color: Color(
                            int.parse(color),
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
