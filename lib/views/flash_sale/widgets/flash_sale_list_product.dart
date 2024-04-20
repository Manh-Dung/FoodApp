import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/flash_sale/widgets/flash_sale_product.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/product/product.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class FlashSaleListProduct extends StatelessWidget {
  final List<Product> listProduct;
  final bool isShimmerLoading;
  final ScrollController? scrollController;

  const FlashSaleListProduct(
      {super.key,
      required this.listProduct,
      required this.isShimmerLoading,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    var list = ListView.separated(
        shrinkWrap: true,
        controller: scrollController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return FlashSaleProduct(product: listProduct[index]);
        },
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: MyColor.DIVIDER_COLOR),
        itemCount: listProduct.length);

    return isShimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: list,
          )
        : list;
  }
}
