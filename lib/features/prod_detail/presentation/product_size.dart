// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/shared/product/model/product_global_model.dart' as p;
import 'package:flutter/material.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key? key,
    required this.product,
  }) : super(key: key);

  final p.Product product;

  @override
  Widget build(BuildContext context) {
    // List<Color> colorList = const [
    //   Color.fromRGBO(27, 32, 40, 0.3),
    //   Color(0xff1B2028),
    //   Color(0xff292526),
    // ];

    final colorList = product.listSizeColor;

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
                  itemCount: colorList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final size = colorList![index].size;
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
                          size,
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
                  itemCount: colorList?.length ?? 0,
                  itemBuilder: (context, index) {
                    debugPrint(colorList?.first.color.colorCode);
                    final color = colorList![index].color.colorCode;
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Container(
                        // height: 30,
                        width: 30,
                        decoration: BoxDecoration(
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
