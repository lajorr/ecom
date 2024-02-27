import 'package:easy_localization/easy_localization.dart';
import '../../../../constants/string_constants.dart';
import '../../../../shared/catalog/model/product_model.dart' as p;
import 'package:flutter/material.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key? key,
    required this.product,
  }) : super(key: key);

  final p.ProductModel product;

  @override
  Widget build(BuildContext context) {
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
              ).tr(),
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
              ).tr(),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: colorList?.length ?? 0,
                  itemBuilder: (context, index) {
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
