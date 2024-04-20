import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/product/product.dart';
import '../../../x_res/my_config.dart';
import '../../../x_res/x_r.dart';

class SpecificationWidget extends StatelessWidget {
  final Product? product;
  final bool shimmerLoading;

  const SpecificationWidget({super.key, required this.product, required this.shimmerLoading});

  @override
  Widget build(BuildContext context) {
    return shimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: _widget())
        : _widget();
  }

  Widget _widget() {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Chi tiết sản phẩm ",
                    style:
                        TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400)),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return Container(
                            width: Get.width,
                            child: Stack(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Chi tiết sản phẩm",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16),
                                                )),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: SvgPicture.asset(XR().svgImage.ic_x)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 42),
                                    Text(
                                        product?.description ?? "Không có mô tả",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, -3)),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                          color: MyColor.PRIMARY_COLOR,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Text(
                                        "Đồng ý",
                                        style: TextStyle(
                                            color: MyColor.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.black,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
