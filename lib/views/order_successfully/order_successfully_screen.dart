import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';

import '../../x_utils/widgets/my_grid_view.dart';
import 'order_successfully_binding.dart';

class OrderSuccessfullyScreen extends BaseView<OrderSuccessfullyController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 13),
              color: MyColor.white,
              child: Column(
                children: [
                  Text(
                    'Bạn đã đặt hàng thành công!',
                    style: TextStyle(
                      color: MyColor.black_80,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 11),
                  Text(
                    'Đơn hàng sẽ được giao cho đơn vị vận chuyển',
                    style: TextStyle(
                      color: MyColor.TEXT_COLOR,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 13),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          child: OutlinedButton(
                            onPressed: () => Get.toNamed(RouterName.home),
                            child: Text(
                              "Trang chủ",
                              style: TextStyle(
                                  color: Color.fromRGBO(34, 161, 33, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: MyColor.white,
                                side: BorderSide(color: Color.fromRGBO(34, 161, 33, 1)),
                                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          child: OutlinedButton(
                            onPressed: () => Get.toNamed(RouterName.order),
                            child: Text(
                              "Đơn hàng đã mua",
                              style: TextStyle(
                                  color: Color.fromRGBO(34, 161, 33, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: MyColor.white,
                                side: BorderSide(color: Color.fromRGBO(34, 161, 33, 1)),
                                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: Get.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                "Sản phẩm cùng loại",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _sortedList())
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: MyColor.white),
        onPressed: () => Get.toNamed(RouterName.home),
      ),
      title: Text(
        "Thanh toán",
        style: TextStyle(
          color: MyColor.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            while (Get.previousRoute != RouterName.cart) {
              Get.back();
            }
          },
          child: Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(XR().svgImage.ic_cart_product),
          ),
        ),
        const SizedBox(width: 16),
      ],
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: MyColor.PRIMARY_COLOR,
        ),
      ),
    );
  }

  Widget _sortedList() {
    return Obx(() => MyGridView(
          shimmerLoading: controller.rxShimmerLoading.value,
          listProduct: controller.rxListProduct,
          listLength: controller.rxListProduct.length,
          scrollController: controller.scrollController1,
          paddingVertical: 0,
          paddingHorizontal: 0,
        ));
  }
}
