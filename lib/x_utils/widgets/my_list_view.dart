import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ints/views/home/widgets/home_product_hot_deals_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../base/base_controller.dart';
import '../../models/product/product.dart';

class MyListView extends StatelessWidget {
  final List<dynamic> listModelWidget;
  final Widget Function(dynamic modelWidget) itemBuilder;
  final int listLength;
  final bool shimmerLoading;

  const MyListView(
      {super.key,
      required this.listModelWidget,
      required this.listLength,
      required this.shimmerLoading,
      required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    final listView = ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 225.0),
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return itemBuilder(listModelWidget[index]);
          },
          separatorBuilder: (_, int index) => SizedBox(width: 10),
          itemCount: listLength),
    );

    return shimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: listView)
        : listView;
  }
}
