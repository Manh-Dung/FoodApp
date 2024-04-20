import 'package:flutter/material.dart';
import 'package:ints/x_utils/widgets/my_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../base/base_view_view_model.dart';
import '../../../models/product/product.dart';

class CartEmptyWidget extends StatelessWidget {
  final List<Product> listProduct;
  final ScrollController scrollController;
  final bool shimmerLoading;

  const CartEmptyWidget(
      {super.key,
      required this.listProduct,
      required this.scrollController,
      required this.shimmerLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: MyColor.BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: MyColor.BACKGROUND_COLOR,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 36),
                  Image.asset(
                    XR().assetsImage.img_empty_cart,
                    width: 132,
                    height: 132,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Không có gì trong giỏ hàng',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: MyColor.TEXT_COLOR_NEW,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hãy quay lại trang chủ để lựa hàng bạn nhé!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.TEXT_COLOR_NEW,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      Get.back(result: 0);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: MyColor.PRIMARY_COLOR, width: 1),
                      ),
                      child: Text("Mua sắm ngay",
                          style: TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text("Có thể bạn sẽ thích",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.black,
                    )),
              ),
              shimmerLoading
                  ? Shimmer.fromColors(
                      baseColor: MyColor.SHIMMER_BASE_COLOR,
                      highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
                      child: Container(
                          width: double.infinity,
                          color: MyColor.BACKGROUND_COLOR,
                          child: MyGridView(
                            listProduct: listProduct,
                            listLength: listProduct.length,
                            scrollController: scrollController,
                            shimmerLoading: shimmerLoading,
                            paddingVertical: 8,
                            paddingHorizontal: 16,
                          )),
                    )
                  : Container(
                      width: double.infinity,
                      color: MyColor.BACKGROUND_COLOR,
                      child: MyGridView(
                          listProduct: listProduct,
                          listLength: listProduct.length,
                          scrollController: scrollController,
                          shimmerLoading: shimmerLoading, paddingVertical: 8, paddingHorizontal: 16,))
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(result: 0),
      ),
      title: Text(
        'Giỏ hàng',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w700,
          color: MyColor.TEXT_COLOR_NEW,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
