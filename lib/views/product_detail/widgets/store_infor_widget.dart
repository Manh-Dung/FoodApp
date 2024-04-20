import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/store/store.dart';
import '../../../x_utils/utilities.dart';

class StoreInforWidget extends StatelessWidget {
  final Store store;
  final bool shimmerLoading;

  const StoreInforWidget({super.key, required this.store, required this.shimmerLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouterName.store_detail, arguments: {'store': store});
      },
      child: shimmerLoading
          ? Shimmer.fromColors(
              baseColor: MyColor.SHIMMER_BASE_COLOR,
              highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
              child: _widget(),
            )
          : _widget(),
    );
  }

  Widget _widget() {
    return Container(
      color: Colors.white,
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyLoadingImage(
                imageUrl: store.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : store.image?[0].path ?? "",
                size: 50,
                isCircle: true,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.name ?? "Cửa hàng",
                      style: TextStyle(
                          fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Đánh giá: ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w400)),
                      Text(store.rating != null ? store.rating.toString() : 'Chưa có',
                          style: TextStyle(
                              fontSize: 13,
                              color: MyColor.PRIMARY_COLOR.withOpacity(0.7),
                              fontWeight: FontWeight.w400)),
                      const SizedBox(width: 10),
                      Text("Sản phẩm: ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w400)),
                      Text(store.totalProduct.toString(),
                          style: TextStyle(
                              fontSize: 13,
                              color: MyColor.PRIMARY_COLOR.withOpacity(0.7),
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Tham gia: ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w400)),
                      Text(Utilities().formatDate(store.createdAt.toString()),
                          style: TextStyle(
                              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
