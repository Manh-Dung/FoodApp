import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/category/category.dart';

class BottomSheetDialog extends StatelessWidget {
  final List<Category>? listCategory;
  final bool shimmerLoading;

  BottomSheetDialog({required this.listCategory, required this.shimmerLoading});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.1,
      maxChildSize: 1,
      // chỗ này để kéo cả cái modalBottomSheet theo
      expand: false,

      builder: (context, scrollController) {
        return Column(
          children: [
            Center(
              child: Text(
                "Danh mục mặt hàng",
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouterName.category_detail,
                          arguments: {'category': listCategory?[index]});
                    },
                    child: shimmerLoading
                        ? Shimmer.fromColors(
                            baseColor: MyColor.SHIMMER_BASE_COLOR,
                            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
                            child: _item(index))
                        : _item(index),
                  );
                },
                itemCount: listCategory?.length,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _item(int index) {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(XR().assetsImage.img_logo, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Text(
            listCategory?[index].name ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
