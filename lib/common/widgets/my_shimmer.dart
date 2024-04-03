import 'package:ecom/constants/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  const MyShimmer({
    required this.child, super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Shimmer.fromColors(
      baseColor: brightness == Brightness.dark
          ? ColorUtils.kShimmerBaseColorDark
          : ColorUtils.kShimmerBaseColorLight,
      highlightColor: brightness == Brightness.dark
          ? ColorUtils.kShimmerHighlightColorDark
          : ColorUtils.kShimmerHighlightColorLight,
      child: child,
    );
  }
}
