import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/nearby_product/widgets/nearby_product_widget.dart';

import 'nearby_product_binding.dart';

class NearByProductScreen extends BaseView<NearByProductController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyColor.PRIMARY_COLOR,
                      Color.fromRGBO(0, 1, 0, 0.8),
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giao đến:',
                        style: TextStyle(color: MyColor.white),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: MyColor.white,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              controller.defaultAddress,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: MyColor.white),
                            ),
                          ),
                          IconButton(
                              icon: SvgPicture.asset(
                                XR().svgImage.ic_arrow_right,
                                color: MyColor.white,
                              ),
                              onPressed: () {
                                Get.toNamed(RouterName.pickup_address);
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: SvgPicture.asset(
                          XR().svgImage.ic_back,
                        ),
                        onPressed: () {
                          Get.back();
                        }),
                    Text('Gần tôi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(78, 79, 84, 1),
                        )),
                    IconButton(
                        icon: SvgPicture.asset(
                          XR().svgImage.ic_cart_product,
                          colorFilter: ColorFilter.mode(
                              MyColor.TEXT_COLOR, BlendMode.srcIn),
                        ),
                        onPressed: () {
                          Get.toNamed(RouterName.cart);
                        }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              controller.onRefresh();
            },
            child: ListView.separated(
              separatorBuilder: (_, index) =>
                  Divider(height: 0.1, color: MyColor.DIVIDER_COLOR),
              controller: controller.scrollCtrl,
              itemBuilder: (_, index) {
                return NearByProduct(
                  product: controller.rxListNearByProduct[index],
                );
              },
              itemCount: controller.rxListNearByProduct.length,
              shrinkWrap: true,
            ),
          ))
        ],
      )),
    );
  }
}
