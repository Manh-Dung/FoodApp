import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/store_detail/store_detail_binding.dart';
import 'package:ints/views/store_detail/widgets/basic_infor_store.dart';
import 'package:ints/views/store_detail/widgets/headerBtn.dart';
import 'package:ints/views/store_detail/widgets/store_detail_screen_search_bar.dart';
import 'package:ints/x_utils/widgets/my_grid_view.dart';

class StoreDetailScreen extends BaseView<StoreDetailController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      backgroundColor: MyColor.BACKGROUND_COLOR,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onRefresh();
        },
        child: SafeArea(
            child: Obx(() => Column(
                  children: [
                    Column(
                      children: [
                        Stack(children: [
                          Container(
                            height: controller.rxBannerHeight.value,
                            width: Get.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(34, 161, 33, 1),
                                  Color.fromRGBO(0, 1, 0, 1),
                                ],
                              ),
                            ),
                          ),
                          _headerBar(),
                          BasicInforStore(
                            store: controller.rxStore.value,
                            opacity: controller.rxOpacity.value,
                            likeShopFunction: () =>
                                controller.addFavoriteStatus(
                                    controller.rxStore.value.id ?? 0),
                            unlikeShopFunction: () =>
                                controller.removeFavoriteStatus(
                                    controller.rxStore.value.id ?? 0),
                            isLiked: controller.isFavoriteStore.value,
                            totalRating: controller.rxStore.value.rating ?? 0,
                          )
                        ]),
                        _tabBar(),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            _sortedProductList(),
                            _sortedProductList(),
                          ]),
                    )
                  ],
                ))),
      ),
    );
  }

  Widget _headerBar() {
    return Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 16, right: 32, top: 15, bottom: 0),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HeaderBtn(
                  onTap: () {
                    Get.back();
                    controller.homeController.getStores().then((value) {
                      controller.homeController.rxListStore.value =
                          value.data ?? [];
                      controller.homeController.getAllFavoriteStore().then(
                          (value) => controller.homeController.rxListFavorite
                              .value = value.data ?? []);
                      controller.update();
                    });
                  },
                  icon: SvgPicture.asset(
                    XR().svgImage.ic_back,
                    colorFilter:
                        ColorFilter.mode(MyColor.white, BlendMode.srcIn),
                  )),
              Expanded(child: StoreDetailScreenSearchBar(), flex: 7),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      height: 50,
      color: MyColor.white,
      child: Obx(
        () => TabBar(
          tabAlignment: TabAlignment.fill,
          controller: controller.tabController,
          labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
          isScrollable: false,
          tabs: controller.rxTabNameList.asMap().entries.map((entry) {
            final tabName = entry.value;
            return Tab(
              child: Padding(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: Container(
                  child: Center(
                    child: Text(
                      tabName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(78, 79, 84, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          onTap: (index) {},
        ),
      ),
    );
  }

  Widget _sortedProductList() {
    return MyGridView(
      shimmerLoading: controller.rxShimmerLoading.value,
      listProduct: controller.rxListProduct,
      listLength: controller.rxListProduct.length,
      scrollController: controller.scrollController,
      paddingVertical: 8,
      paddingHorizontal: 16,
    );
  }
}
