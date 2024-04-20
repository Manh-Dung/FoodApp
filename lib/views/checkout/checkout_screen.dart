import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/checkout/checkout_binding.dart';
import 'package:ints/views/checkout/widgets/address_widget.dart';
import 'package:ints/views/checkout/widgets/checkout_btn.dart';
import 'package:ints/views/checkout/widgets/checkout_item.dart';
import 'package:ints/views/checkout/widgets/shipping_method.dart';
import 'package:ints/x_utils/utilities.dart';

class CheckoutScreen extends BaseView<CheckoutController> {
  @override
  Widget vBuilder() {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (Get.previousRoute == RouterName.product_detail) {
            controller.deleteCartItem(
                controller.rxOrderItem.value?.cartItems?[0].id ?? 0);
            while (Get.currentRoute != RouterName.product_detail) {
              Get.back();
            }
          } else {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: MyColor.BACKGROUND_COLOR),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() => AddressWidget(
                        name: controller.rxDefaultAddress.value?.fullName ??
                            "Họ và tên",
                        phone: controller.rxDefaultAddress.value?.phoneNumber ??
                            "Số điện thoại",
                        address: (controller.rxDefaultAddress.value?.district ??
                                "Tỉnh") +
                            ", " +
                            (controller.rxDefaultAddress.value?.district ??
                                "Quận") +
                            ", " +
                            (controller.rxDefaultAddress.value?.ward ?? "Xã"),
                        detailAddress:
                            controller.rxDefaultAddress.value?.addressDetail ??
                                "Địa chỉ chi tiết",
                      )),
                  const SizedBox(height: 4),
                  controller.isBuyNowSelection
                      ? Obx(() => CheckoutCart(
                            noteController: controller.noteController,
                            orderItem: controller.rxOrderItem.value,
                            cartItem: controller.rxCartItem.value,
                          ))
                      : Obx(
                          () => ListView.builder(
                            itemBuilder: (_, index) {
                              return CheckoutItem(
                                cartList: controller.rxReceivedListCart,
                                index: index,
                                noteController: controller.noteController,
                                cartItemsList: controller.rxListCartItem,
                              );
                            },
                            itemCount: controller.rxReceivedListCart.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                  ShippingMethod(
                    totalCoint:
                        controller.appController.rxUser.value?.point ?? 0,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CheckoutBtn(
          onPressed: () {
            controller.isBuyNowSelection
                ? controller.checkoutBuyNow(
                    addressId: controller.rxDefaultAddress.value?.id ?? 0,
                    note: controller.noteController.text,
                    listCartId: controller.rxListCartId,
                    point: controller.pointController.text.isEmpty
                        ? 0
                        : int.parse(controller.pointController.text))
                : controller.checkout(
                    addressId: controller.rxDefaultAddress.value?.id ?? 0,
                    note: controller.noteController.text,
                    listCartId: controller.rxListCartItemId,
                    point: controller.pointController.text.isEmpty
                        ? 0
                        : int.parse(controller.pointController.text));
          },
          totalAmount: controller.isBuyNowSelection
              ? Utilities()
                  .moneyFormater(controller.rxTotalOrderPrice.value.toString())
              : Utilities().moneyFormater(controller.totalPrice.toString()),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () {
          if (Get.previousRoute == RouterName.product_detail) {
            controller.deleteCartItem(
                controller.rxOrderItem.value?.cartItems?[0].id ?? 0);
            while (Get.currentRoute != RouterName.product_detail) {
              Get.back();
            }
          } else {
            Get.back();
          }
        },
      ),
      title: Text('Thanh toán',
          style: TextStyle(
            fontSize: 21,
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
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
