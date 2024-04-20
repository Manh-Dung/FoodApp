import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../base/base_controller.dart';
import '../../../models/store/store.dart';

class HomeStoreWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Store store;
  final bool isFavorite;

  const HomeStoreWidget(
      {super.key, required this.onTap, required this.store, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MyColor.BORDER_COLOR, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    MyLoadingImage(
                      imageUrl: store.image?.length == 0
                          ? "https://picsum.photos/200/300"
                          : store.image?[0].path ?? "",
                      size: 40,
                      isCircle: true,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name ?? "Cửa hàng",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              XR().svgImage.ic_heart_outline,
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              store.totalFavorite.toString() + " yêu thích",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.TEXT_COLOR_NEW),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isFavorite ? MyColor.white : MyColor.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isFavorite ? MyColor.PRIMARY_COLOR : MyColor.white,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    isFavorite ? "Đã thích" : "Yêu thích",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isFavorite ? MyColor.PRIMARY_COLOR : MyColor.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
