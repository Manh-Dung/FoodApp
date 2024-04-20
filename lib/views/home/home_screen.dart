import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/home/home_binding.dart';
import 'package:ints/views/home/pages/home_page.dart';
import 'package:ints/views/home/widgets/nav_item.dart';

import 'pages/account_page.dart';

class HomeScreen extends BaseView<HomeController> {
  @override
  Widget vBuilder() {
    controller.tabController.addListener(() {
      controller.currentPage.value = controller.tabController.index;
    });
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: Obx(() => _navBar()),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: [
            HomePage(
              onBack: (int cartCount) {
                controller.rxCartCount.value = cartCount;
              },
            ),
            Container(),
            Container(),
            Container(),
            AccountPage(),
          ],
        ),
      ),
    );
  }

  Widget _navBar() {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              index: 0,
              icon: controller.currentPage.value != 0
                  ? XR().svgImage.ic_home_outline
                  : XR().svgImage.ic_home,
              title: "Trang chủ",
              onTap: () {
                controller.currentPage.value = 0;
                controller.tabController.animateTo(0);
              },
              isSelected: controller.currentPage.value == 0,
            ),
            NavItem(
                index: 1,
                icon: controller.currentPage.value != 1
                    ? XR().svgImage.ic_heart_outline
                    : XR().svgImage.ic_heart,
                title: "Yêu thích",
                onTap: () {
                  controller.currentPage.value = 0;
                  controller.tabController.animateTo(0);
                  Get.toNamed(RouterName.favorite_store);
                },
                isSelected: controller.currentPage.value == 1,
                isLogin: controller.appController.isLogin.value == true),
            NavItem(
                index: 2,
                icon: controller.currentPage.value != 2
                    ? XR().svgImage.ic_cart_outline
                    : XR().svgImage.ic_cart,
                title: "Giỏ hàng",
                onTap: () async {
                  var data = await Get.toNamed(RouterName.cart);
                  controller.rxCartCount.value = data;
                  controller.currentPage.value = 0;
                  controller.tabController.animateTo(0);
                },
                isSelected: controller.currentPage.value == 2,
                cartCount: controller.rxCartCount.value,
                isLogin: controller.appController.isLogin.value == true),
            NavItem(
                index: 3,
                icon: controller.currentPage.value != 3
                    ? XR().svgImage.ic_messenger_outline
                    : XR().svgImage.ic_messenger,
                title: "Tin nhắn",
                onTap: () {
                  controller.currentPage.value = 0;
                  controller.tabController.animateTo(0);
                  Get.toNamed(RouterName.chat_page_noti);
                },
                isSelected: controller.currentPage.value == 3,
                chatCount: 1,
                isLogin: controller.appController.isLogin.value == true),
            NavItem(
              index: 4,
              icon: controller.currentPage.value != 4
                  ? XR().svgImage.ic_account_outline
                  : XR().svgImage.ic_account,
              title: "Tài khoản",
              onTap: () {
                controller.currentPage.value = 4;
                controller.tabController.animateTo(4);
              },
              isSelected: controller.currentPage.value == 4,
              isLogin: controller.appController.isLogin.value == true,
            ),
          ],
        ),
      ),
    );
  }
}
