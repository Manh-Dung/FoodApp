import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/search_order/widgets/search_order_empty_page.dart';
import 'package:ints/views/search_order/widgets/search_order_header.dart';

import '../order/widgets/order_item_widget.dart';
import 'search_order_binding.dart';

class SearchOrderScreen extends BaseView<SearchOrderController> {
  @override
  Widget vBuilder() => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.BACKGROUND_COLOR,
        appBar: _appBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            return controller.onRefresh();
          },
          child: SafeArea(
            child: Column(
              children: [
                SearchOrderHeader(
                  onChanged: (String value) {
                    controller.rxSearchValue.value = value;
                    if (value.isNotEmpty) {
                      controller.getOrders(search: value).then((res) {
                        controller.rxListOrder.value = res.data ?? [];
                      });
                    }
                  },
                ),
                Obx(() => controller.rxSearchValue.value == ""
                    ? SearchOrderEmptyPage()
                    : Obx(() => _orderProductList())),
              ],
            ),
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
      title: Text("Tìm kiếm đơn hàng",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: MyColor.TEXT_COLOR_NEW,
          )),
      centerTitle: true,
    );
  }

  Widget _orderProductList() {
    return Expanded(
      child: ListView.separated(
        itemCount: controller.rxListOrder.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        controller: controller.scrollController,
        itemBuilder: (BuildContext context, int index) {
          return OrderItemWidget(
            onTapBuy: () {
              controller.buyAgain(controller.rxListOrder[index]);
            },
            order: controller.rxListOrder[index],
            onTapRating: () {},
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
            onTapCancel: () {},
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
