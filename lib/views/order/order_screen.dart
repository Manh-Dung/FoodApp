import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/order/widgets/order_item_widget.dart';

import 'order_binding.dart';

class OrderScreen extends BaseView<OrderController> {
  @override
  Widget vBuilder() => Scaffold(
        backgroundColor: MyColor.BACKGROUND_COLOR,
        appBar: _appBar(),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Container(
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
                    child: TabBar(
                      controller: controller.tabController,
                      tabs: controller.rxTabNameList
                          .map((e) => Tab(text: e))
                          .toList(),
                      isScrollable: true,
                      labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_COLOR_NEW),
                      tabAlignment: TabAlignment.start,
                      onTap: (index) {
                        controller.tabController.index = index;
                        controller.rxPage.value = 1;

                        controller
                            .getOrders(
                                status: controller.rxTabStatusList[index],
                                page: controller.rxPage.value,
                                limit: controller.rxLimit.value,
                                createAt: controller.rxCreatedAt.value,
                                search: controller.orderSearchController.text)
                            .then((res) {
                          controller.rxListOrder.value = res.data ?? [];
                        });
                      },
                    ),
                  )),
              const SizedBox(height: 8),
              Obx(
                () => Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        _orderProductList(),
                        _orderProductList(),
                        _orderProductList(),
                        _orderProductList(),
                        _orderProductList(),
                        _orderProductList(),
                      ]),
                ),
              )
            ],
          ),
        ),
      );

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text("Lịch sử mua hàng",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: MyColor.TEXT_COLOR_NEW,
          )),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(RouterName.search_order);
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SvgPicture.asset(XR().svgImage.ic_search)),
        ),
      ],
    );
  }

  Widget _orderProductList() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: ListView.separated(
        itemCount: controller.rxListOrder.length,
        shrinkWrap: true,
        controller: controller.scrollController,
        itemBuilder: (BuildContext context, int index) {
          return OrderItemWidget(
            onTapBuy: () {
              controller.buyAgain(controller.rxListOrder[index]);
            },
            order: controller.rxListOrder[index],
            onTapRating: () {
              Get.toNamed(RouterName.feedback,
                  arguments: {"order": controller.rxListOrder[index]});
            },
            onTapProduct: (productId) {
              controller.getProductById(id: productId).then((value) {
                controller.rxProduct.value = value;
                Navigator.pushNamed(Get.context!, RouterName.product_detail,
                    arguments: {
                      "product": controller.rxProduct.value?.toJson()
                    });
              });
            },
            onTapStore: (num id) {
              controller.getStoreById(storeId: id).then((value) {
                controller.rxStore.value = value;
                Get.toNamed(RouterName.store_detail,
                    arguments: {"store": controller.rxStore.value});
              });
            },
            onTapCancel: () {
              controller.cancelOrder(
                  orderId: controller.rxListOrder[index].id ?? 0);
            },
            onTapChat: () {},
            onTapOrderDetail: (num id) {
              controller.getOrderById(id: id).then((value) => Get.toNamed(
                  RouterName.order_detail,
                  arguments: {"order": value}));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(height: 4, color: MyColor.BACKGROUND_COLOR);
        },
      ),
    );
  }
}
