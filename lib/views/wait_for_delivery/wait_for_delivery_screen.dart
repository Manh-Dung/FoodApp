import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/order/widgets/order_item_widget.dart';
import 'package:ints/views/wait_for_delivery/wait_for_delivery_binding.dart';
import 'package:ints/views/wait_for_delivery/widgets/wait_empty_list_widget.dart';

import '../../x_utils/widgets/my_grid_view.dart';

class WaitForDeliveryScreen extends BaseView<WaitForDeliveryController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      backgroundColor: MyColor.BACKGROUND_COLOR,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Chờ lấy hàng",
              style: TextStyle(
                  color: MyColor.TEXT_COLOR_NEW,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 2),
            Obx(
              () => Text(
                '(${controller.rxListOrder.length.toString()})',
                style: TextStyle(
                    color: MyColor.PRIMARY_COLOR,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => controller.rxListOrder.length == 0
                ? WaitEmptyListWidget()
                : _listWaitOrder()),
            const SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              width: Get.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                "Sản phẩm cùng loại",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _sortedList())
          ],
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

  Widget _listWaitOrder() {
    return ListView.separated(
      itemBuilder: (_, index) {
        return OrderItemWidget(
          onTapBuy: () {
            controller.buyAgain(controller.rxListOrder[index]);
          },
          order: controller.rxListOrder[index],
          onTapRating: () {},
          onTapStore: (num id) {
            controller
                .getStoreById(storeId: id)
                .then((value) => controller.rxStore.value = value);
            Get.toNamed(RouterName.store_detail,
                arguments: {"store": controller.rxStore.value});
          },
          onTapProduct: (num id) {
            controller.getProductById(id: id).then((value) =>
                Navigator.pushNamed(Get.context!, RouterName.product_detail,
                    arguments: {"product": value.toJson()}));
          },
          onTapCancel: () {},
          onTapChat: () {},
          onTapOrderDetail: (num id) {
            controller.getOrderById(id: id).then((value) => Get.toNamed(
                RouterName.order_detail,
                arguments: {"order": value}));
          },
        );
      },
      itemCount: controller.rxListOrder.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
    );
  }
}
