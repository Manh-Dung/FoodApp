import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ints/x_utils/widgets/product_widget_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/product/product.dart';
import '../../x_res/my_config.dart';

class MyGridView extends StatelessWidget {
  final List<Product> listProduct;
  final int listLength;
  final ScrollController scrollController;
  final bool shimmerLoading;
  final double paddingVertical;
  final double paddingHorizontal;

  const MyGridView(
      {Key? key,
      required this.listProduct,
      required this.listLength,
      required this.scrollController,
      required this.shimmerLoading,
      required this.paddingVertical,
      required this.paddingHorizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productWidgets = Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
        controller: scrollController,
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: (listLength / 2).ceil(),
        itemBuilder: (BuildContext context, int index) {
          final firstItemIndex = index * 2;
          final secondItemIndex = firstItemIndex + 1;

          return Row(
            children: [
              Expanded(
                child: ProductWidgetGridView(
                  product: listProduct[firstItemIndex],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: secondItemIndex < listLength
                    ? ProductWidgetGridView(
                        product: listProduct[secondItemIndex],
                      )
                    : Container(),
              ),
            ],
          );
        },
      ),
    );

    return shimmerLoading
        ? Shimmer.fromColors(
            child: productWidgets,
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR)
        : productWidgets;
  }
}
