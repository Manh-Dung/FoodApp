import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/models/cart/cart.dart';
import 'package:ints/views/home/widgets/cart_empty_widget.dart';

import '../../../base/base_view_view_model.dart';
import '../../cart/cart_binding.dart';
import '../widgets/cart_bottom_bar.dart';
import '../widgets/cart_item_widget.dart';

class CartPage extends BaseView<CartController> {
  @override
  Widget vBuilder() {
    return RefreshIndicator(
      onRefresh: () async {
        return controller.onRefresh();
      },
      child: Obx(() => controller.rxListCart.length == 0
          ? CartEmptyWidget(
              listProduct: controller.rxListProduct,
              scrollController: controller.scrollController,
              shimmerLoading: controller.rxShimmerLoading.value,
            )
          : Obx(() => _notEmptyCart())),
    );
  }

  Widget _buildItemCart({required List<Cart> cart, required int index}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cart[index].cartItems?.length,
        itemBuilder: (context, index2) {
          return Obx(() => ItemCartWidget(
                item: cart[index].cartItems?[index2],
                isChecked: controller.rxListCartItemSelect
                    .where((p0) => p0.id == cart[index].cartItems?[index2].id)
                    .isNotEmpty,
                onPressed: (quantity) {
                  controller.changeQuantity(
                      quantity, cart[index].cartItems?[index2]);
                },
                isEdit: controller.rxListShopSelectEdit[index],
                onCheckBoxChanged: (bool value) {
                  controller.onCheckBoxChanged(
                      value, cart[index].cartItems?[index2], index);
                },
                onEdit: () {
                  controller.showAlertDialog(
                      cartItem: cart[index].cartItems?[index2], index: index);
                },
              ));
        });
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(result: controller.rxListCart.length),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Giỏ hàng',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: MyColor.TEXT_COLOR_NEW,
              ),
            ),
            TextSpan(
              text: " (${controller.rxListCart.length})",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: MyColor.PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Obx(() => InkWell(
              onTap: () {
                controller.onBarEditCheck();
              },
              child: Text(controller.rxIsEditAll.value ? "Xong" : "Sửa",
                  style: TextStyle(
                    color: MyColor.TEXT_COLOR_NEW,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
            )),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {},
          child: Container(
            width: 24,
            height: 24,
            child: SvgPicture.asset(XR().svgImage.ic_chat),
          ),
        ),
        const SizedBox(width: 20),
      ],
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

  Widget _cartListBuilder(int index) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rxListShopSelectCheck[index],
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          activeColor: MyColor.white,
                          checkColor: MyColor.PRIMARY_COLOR,
                          side: MaterialStateBorderSide.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return BorderSide(
                                    color: MyColor.CHECKBOX_COLOR, width: 1.0);
                              }
                              return BorderSide(color: Colors.grey, width: 1.0);
                            },
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          focusColor: Colors.grey,
                          hoverColor: Colors.grey,
                          onChanged: (value) {
                            controller.onShopCheckBoxChanged(value, index);
                          })),
                      const SizedBox(width: 4),
                      Text(
                        "${controller.rxListCart[index].store?.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.chevron_right_rounded,
                          color: MyColor.TEXT_COLOR_NEW),
                    ],
                  ),
                  Obx(() => InkWell(
                        onTap: () {
                          controller.onShopEdit(index);
                        },
                        child: Text(
                            controller.rxListShopSelectEdit[index]
                                ? "Xong"
                                : "Sửa",
                            style: TextStyle(
                              color: MyColor.TEXT_COLOR_NEW,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            )),
                      )),
                ]),
          ),
          Divider(height: 1, color: MyColor.DIVIDER_COLOR),
          Obx(() => _buildItemCart(cart: controller.rxListCart, index: index)),
        ],
      ),
    );
  }

  Widget _notEmptyCart() {
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: MyColor.BACKGROUND_COLOR,
        body: ListView.separated(
          itemCount: controller.rxListCart.length,
          itemBuilder: (context, index) {
            return Obx(() => _cartListBuilder(index));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 4);
          },
        ),
        bottomNavigationBar: Obx(() => CartBottomBar(
              onCheckBoxChanged: (value) {
                controller.onBarCheckBoxChanged(value);
              },
              checkBoxValue: controller.rxIsSelectAllShop.value,
              totalPrice: controller.totalPrice,
              onPressed: () {
                controller.order();
              },
            )));
  }
}
