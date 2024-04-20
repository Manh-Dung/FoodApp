import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/views/home/home_binding.dart';
import 'package:ints/views/home/widgets/home_product_flash_sale_widget.dart';
import 'package:ints/x_utils/widgets/my_list_view.dart';
import 'package:ints/views/home/widgets/home_search_bar.dart';
import 'package:ints/views/home/widgets/home_store_widget.dart';
import 'package:ints/views/home/widgets/notification_widget.dart';

import '../../../base/base_view_view_model.dart';
import '../../../x_utils/widgets/my_grid_view.dart';
import '../widgets/dots_indicator.dart';
import '../widgets/dynamic_slider.dart';
import '../widgets/home_count_down_widget.dart';
import '../widgets/home_product_hot_deals_widget.dart';
import '../widgets/section.dart';

class HomePage extends BaseView<HomeController> {
  final Function(int cartCount) onBack;

  HomePage({super.key, required this.onBack});

  @override
  Widget vBuilder() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: SingleChildScrollView(
        child: Container(
          color: MyColor.BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 60),
                        color: MyColor.PRIMARY_COLOR,
                        child: _headerBar()),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 16, right: 16),
                      color: MyColor.white,
                      child: Column(
                        children: [
                          _dynamicBanner(),
                          _sectionBuilder(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    _flashSale(),
                    const SizedBox(height: 4),
                    Obx(() => (controller.appController.isLogin.value &&
                            controller.rxListNearByProduct.length > 0)
                        ? Container(
                            color: Colors.white, child: _nearbyProductBuilder())
                        : Container()),
                    const SizedBox(height: 4),
                    _hotDeals(),
                    const SizedBox(height: 4),
                    _productsSuggest(),
                  ],
                ),
                Obx(() => _storeListBuilder()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dynamicBanner() {
    return Obx(() => Stack(
          children: [
            DynamicSlider(
              carouselController: controller.carouselController,
              onChanged: (index) {
                controller.currentBanner.value = index;
              },
            ),
            Positioned(
                bottom: 15.0,
                left: 0,
                right: 0,
                child: DotsIndicator(
                  dotsCount: 2,
                  position: controller.currentBanner.value.toDouble(),
                  onChanged: (int value) {
                    controller.carouselController.animateToPage(value);
                    controller.currentBanner.value = value;
                  },
                )),
          ],
        ));
  }

  Container _headerBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.toNamed(RouterName.search_product);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(XR().svgImage.ic_search),
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
              ),
            ),
          ),
          Expanded(
              child: InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.search_product);
                  },
                  child: HomeSearchBar()),
              flex: 7),
          const SizedBox(width: 10),
          Expanded(
              child: InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.notification);
                  },
                  child: NotificationWidget()),
              flex: 1),
        ],
      ),
    );
  }

  Widget _sectionBuilder() {
    return Container(
      padding: const EdgeInsets.only(top: 18, bottom: 6, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Section(path: XR().svgImage.ic_discount, title: "Siêu rẻ"),
              Section(
                  path: XR().svgImage.ic_basket_picnic,
                  title: "Thực phẩm\nkhô"),
              Section(path: XR().svgImage.ic_chicken, title: "Thịt & Hải sản"),
              Section(
                  path: XR().svgImage.ic_vegetable,
                  title: "Rau củ &\nTrái cây"),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 30,
            decoration: BoxDecoration(
                color: MyColor.CHECKBOX_COLOR,
                borderRadius: BorderRadius.circular(100)),
            child: Stack(
              children: [
                Positioned(
                  left: 5,
                  child: Container(
                    height: 4,
                    width: 10,
                    decoration: BoxDecoration(
                        color: MyColor.PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _hotDeals() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deal hot",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.category_detail);
                  },
                  child: Text(
                    "xem thêm >>",
                    style: TextStyle(
                        color: MyColor.PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Obx(() => MyListView(
                  listModelWidget: controller.rxListProduct,
                  listLength: controller.rxListProduct.length,
                  shimmerLoading: controller.rxShimmerLoading.value,
                  itemBuilder: (modelWidget) {
                    return HomeProductHotDealsWidget(
                      product: modelWidget,
                    );
                  },
                ))
          ],
        ));
  }

  Container _flashSale() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "FLASH SALE",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MyColor.FLASH_SALE_COLOR),
                ),
                const SizedBox(width: 8),
                Obx(() => HomeCountDownWidget(
                      hour: controller.rxHour.value,
                      minute: controller.rxMinute.value,
                      second: controller.rxSecond.value,
                    )),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.flash_sale);
                  },
                  child: Text(
                    "xem thêm >>",
                    style: TextStyle(
                        color: MyColor.FLASH_SALE_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Obx(() => MyListView(
                  listModelWidget: controller.rxListProduct,
                  listLength: controller.rxListProduct.length,
                  shimmerLoading: controller.rxShimmerLoading.value,
                  itemBuilder: (modelWidget) {
                    return HomeProductFlashSaleWidget(
                      product: modelWidget,
                    );
                  },
                ))
          ],
        ));
  }

  Container _nearbyProductBuilder() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gần tôi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.nearby_product);
                  },
                  child: Text(
                    "xem thêm >>",
                    style: TextStyle(
                        color: MyColor.PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Obx(() => MyListView(
                  listModelWidget: controller.rxListNearByProduct,
                  listLength: controller.rxListNearByProduct.length,
                  shimmerLoading: controller.rxShimmerLoading.value,
                  itemBuilder: (modelWidget) {
                    return HomeProductHotDealsWidget(
                      product: modelWidget,
                    );
                  },
                ))
          ],
        ));
  }

  Widget _productsSuggest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: MyColor.white,
          width: double.infinity,
          child: Text("Gợi ý cho bạn",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
        ),
        Obx(
          () => MyGridView(
            scrollController: controller.scrollController,
            listProduct: controller.rxListProduct,
            listLength: controller.rxListProduct.length,
            shimmerLoading: controller.rxShimmerLoading.value,
            paddingVertical: 4,
            paddingHorizontal: 16,
          ),
        ),
      ],
    );
  }

  Widget _storeListBuilder() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Gian hàng nổi bật",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              // InkWell(
              //   onTap: () {
              //   },
              //   child: Text(
              //     "xem thêm >>",
              //     style: TextStyle(
              //         color: MyColor.PRIMARY_COLOR,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w400),
              //   ),
              // )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemBuilder: (_, index) {
                return Obx(() => InkWell(
                      onTap: () async {
                        controller
                            .getStoreById(
                                storeId: controller.rxListStore[index].id ?? 0)
                            .then((value) {
                          Get.toNamed(RouterName.store_detail,
                              arguments: {"store": value});
                        });
                      },
                      child: HomeStoreWidget(
                        onTap: () {
                          if (controller.appController.isLogin.value == false) {
                            Get.toNamed(RouterName.choose_login_signup);
                          } else {
                            if (controller.rxListFavorite.any((element) =>
                                element.storeId ==
                                controller.rxListStore[index].id))
                              controller.removeFavorite(
                                  storeId:
                                      controller.rxListStore[index].id ?? 0);
                            else
                              controller.addFavorite(
                                  storeId:
                                      controller.rxListStore[index].id ?? 0);
                          }
                        },
                        store: controller.rxListStore[index],
                        isFavorite:
                            controller.appController.isLogin.value == false
                                ? false
                                : (controller.rxListFavorite.any((element) =>
                                    element.storeId ==
                                    controller.rxListStore[index].id)),
                      ),
                    ));
              },
              itemCount: controller.rxListStore.length,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _seconds = 59;
          if (_minutes > 0) {
            _minutes--;
          } else {
            _minutes = 59;
            if (_hours > 0) {
              _hours--;
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            '${_hours.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 14.0, color: MyColor.white),
          ),
        ),
        const SizedBox(width: 4.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            '${_minutes.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 14.0, color: MyColor.white),
          ),
        ),
        const SizedBox(width: 4.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            '${_seconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 14.0, color: MyColor.white),
          ),
        ),
      ],
    );
  }
}
