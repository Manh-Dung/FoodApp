import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ints/views/order_detail/widgets/order_detail_chat_btn.dart';
import 'package:ints/x_utils/utilities.dart';
import 'package:shimmer/shimmer.dart';

import '../../base/base_view_view_model.dart';
import '../../x_utils/widgets/my_grid_view.dart';
import '../checkout/widgets/address_widget.dart';
import '../order/widgets/order_cart_item_widget.dart';
import '../order/widgets/order_store_widget.dart';
import 'order_detail_binding.dart';
import 'widgets/order_detail_deliver_widget.dart';

class OrderDetailScreen extends BaseView<OrderDetailController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: MyColor.BACKGROUND_COLOR,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onRefresh();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => controller.rxOrder.value?.status != "Deliver"
                    ? Container()
                    : OrderDetailDeliverWidget()),
                AddressWidget(
                  name: controller.rxOrder.value?.fullname ?? "Họ và tên",
                  phone:
                      controller.rxOrder.value?.phoneNumber ?? "Số điện thoại",
                  address: (controller.rxOrder.value?.district ?? "Tỉnh") +
                      ", " +
                      (controller.rxOrder.value?.district ?? "Quận") +
                      ", " +
                      (controller.rxOrder.value?.ward ?? "Xã"),
                  detailAddress: controller.rxOrder.value?.addressDetail ??
                      "Địa chỉ chi tiết",
                ),
                const SizedBox(height: 4),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderStoreWidget(
                        order: controller.rxOrder.value,
                        onTapStore: (num storeId) {
                          controller
                              .getStoreById(storeId: storeId)
                              .then((value) {
                            controller.rxStore.value = value;
                            Get.toNamed(RouterName.store_detail,
                                arguments: {"store": controller.rxStore.value});
                          });
                        },
                      ),
                      Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                      _listCartItems(),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text("Thời gian đặt hàng",
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                      Spacer(),
                      Text(
                          Utilities().formatDate(
                              controller.rxOrder.value?.createdAt ?? ""),
                          style: TextStyle(
                              fontSize: 12, color: MyColor.TEXT_COLOR_NEW)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                _deliverMethodWidget(),
                OrderDetailChatBtn(
                  onTapChat: () {},
                ),
                const SizedBox(height: 4),
                Container(
                  color: MyColor.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(XR().svgImage.ic_coin),
                      const SizedBox(width: 4),
                      Text("Coin nhận được khi mua hàng",
                          style: TextStyle(fontSize: 12, color: MyColor.black)),
                      Spacer(),
                      Obx(() => Text("+${controller.rxTotalPoint}",
                          style: TextStyle(
                              fontSize: 12, color: Color(0xffFDA018)))),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                _listProductBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Thông tin đơn hàng',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listCartItems() {
    return ListView.separated(
      itemCount: controller.rxOrder.value?.cartItems?.length ?? 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderCartItemWidget(
          cartItem: controller.rxOrder.value?.cartItems?[index],
          onTap: () {
            controller
                .getProductById(
                    id: controller.rxOrder.value?.cartItems?[index].productId ??
                        0)
                .then((value) => Navigator.pushNamed(
                    Get.context!, RouterName.product_detail,
                    arguments: {"product": value.toJson()}));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
    );
  }

  Widget _deliverMethodWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      color: Color(0xffE2F5FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phương thức vận chuyển",
              style: TextStyle(fontSize: 12, color: Color(0xff0B9EEA))),
          Text("COD", style: TextStyle(fontSize: 12, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _listProductBuilder() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text("Sản phẩm cùng loại",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.black,
              )),
        ),
        Obx(
          () => controller.rxIsLoading.value
              ? Shimmer.fromColors(
                  baseColor: MyColor.SHIMMER_BASE_COLOR,
                  highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
                  child: Container(
                      width: double.infinity,
                      color: MyColor.BACKGROUND_COLOR,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: MyGridView(
                        listProduct: controller.rxListProduct,
                        listLength: controller.rxListProduct.length,
                        scrollController: controller.scrollController,
                        shimmerLoading: controller.rxIsLoading.value,
                        paddingVertical: 8,
                        paddingHorizontal: 16,
                      )),
                )
              : Container(
                  width: double.infinity,
                  color: MyColor.BACKGROUND_COLOR,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MyGridView(
                    listProduct: controller.rxListProduct,
                    listLength: controller.rxListProduct.length,
                    scrollController: controller.scrollController,
                    shimmerLoading: controller.rxIsLoading.value,
                    paddingVertical: 8,
                    paddingHorizontal: 16,
                  )),
        )
      ],
    );
  }
}
