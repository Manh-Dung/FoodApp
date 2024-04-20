import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/flash_sale/flash_sale_binding.dart';
import 'package:ints/views/home/widgets/home_count_down_widget.dart';
import 'package:ints/x_utils/widgets/my_grid_view.dart';

import 'widgets/flash_sale_list_product.dart';

class FlashSaleScreen extends BaseView<FlashSaleController> {
  @override
  Widget vBuilder() => Scaffold(
        backgroundColor: MyColor.BACKGROUND_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              _headerBar(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Kết thúc trong",
                        style: TextStyle(
                          color: MyColor.BORDER_COLOR,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        )),
                    const SizedBox(width: 6),
                    Obx(() => HomeCountDownWidget(
                        hour: controller.rxHour.value,
                        minute: controller.rxMinute.value,
                        second: controller.rxSecond.value)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Obx(() => _sortedProductList()),
                    Obx(() => _sortedProductList()),
                    Obx(() => _sortedProductList()),
                    Obx(() => _sortedProductList()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _headerBar() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: MyColor.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                icon: SvgPicture.asset(
                  XR().svgImage.ic_back,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterName.search_product);
                  },
                  child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(225, 226, 227, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            SvgPicture.asset(
                              XR().svgImage.ic_search,
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "FLASH SALE",
                              style: TextStyle(
                                color: MyColor.FLASH_SALE_COLOR,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                flex: 7),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouterName.cart);
                },
                child: SvgPicture.asset(XR().svgImage.ic_cart_product),
              ),
            ),
          ],
        ),
        Obx(() => TabBar(
              controller: controller.tabController,
              labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: controller.tabController.index ==
                        controller.currentPage.value
                    ? MyColor.FLASH_SALE_COLOR
                    : MyColor.TEXT_COLOR_NEW,
              ),
              indicatorColor: MyColor.FLASH_SALE_COLOR,
              isScrollable: false,
              tabs: controller.rxTabNameList.asMap().entries.map((entry) {
                final index = entry.key;
                final tabName = entry.value;
                return Tab(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          tabName,
                          style: TextStyle(
                            fontSize: 14,
                            color: controller.tabController.index == index
                                ? MyColor.FLASH_SALE_COLOR
                                : MyColor.TEXT_COLOR_NEW,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text("Đang diễn ra",
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.tabController.index == index
                                  ? MyColor.FLASH_SALE_COLOR
                                  : MyColor.BORDER_COLOR,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
              tabAlignment: TabAlignment.fill,
              onTap: (index) {
                String sortBy;
                String orderBy;

                switch (index) {
                  case 0:
                    sortBy = 'created_at';
                    orderBy = 'DESC';
                    break;
                  case 1:
                    sortBy = 'vote';
                    orderBy = 'DESC';
                    break;
                  case 2:
                    sortBy = 'price';
                    orderBy = 'ASC';
                    break;
                  case 3:
                    sortBy = 'price';
                    orderBy = 'DESC';
                    break;
                  default:
                    sortBy = '';
                    orderBy = '';
                }
                _navButtonHandle(page: index, sortBy: sortBy, orderBy: orderBy);
              },
            )),
      ]),
    );
  }

  void _navButtonHandle(
      {required int page, required String sortBy, required String orderBy}) {
    controller.currentPage.value = page;
    controller.rxPage.value = 1;

    controller
        .getProducts(
            sortBy: sortBy,
            orderBy: orderBy,
            page: controller.rxPage.value,
            limit: controller.limit)
        .then((res) {
      controller.rxListProduct.value = res.data ?? [];
      controller.update();
    });
  }

  Widget _sortedProductList() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: FlashSaleListProduct(
        listProduct: controller.rxListProduct,
        isShimmerLoading: controller.rxShimmerLoading.value,
        scrollController: controller.scrollController,
      ),
    );
  }
}
