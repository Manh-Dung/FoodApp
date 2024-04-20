import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/category_detail/category_detail_binding.dart';
import 'package:ints/x_utils/widgets/my_grid_view.dart';

class CategoryDetailScreen extends BaseView<CategoryDetailController> {
  @override
  Widget vBuilder() => Scaffold(
        backgroundColor: MyColor.BACKGROUND_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              _headerBar(),
              SizedBox(height: 3),
              Obx(() => Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          _sortedProductList(),
                          _sortedProductList(),
                          _sortedProductList(),
                          _sortedProductList(),
                        ]),
                  )),
            ],
          ),
        ),
      );

  PhysicalModel _headerBar() {
    return PhysicalModel(
      elevation: 8,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.25).withOpacity(0.3),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(top: 15),
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
                              Obx(() => Text(
                                controller.rxSearch.value ?? 'Sản phẩm',
                                style: TextStyle(
                                  color: MyColor.PRIMARY_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              )) ,
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
                isScrollable: false,
                tabs: controller.rxTabNameList.asMap().entries.map((entry) {
                  final index = entry.key;
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
                        decoration: index < controller.rxTabNameList.length - 1
                            ? BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey,
                                    width: 0.3,
                                  ),
                                ),
                              )
                            : null,
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

                  _navButtonHandle(
                      page: index, sortBy: sortBy, orderBy: orderBy);
                },
              )),
        ]),
      ),
    );
  }

  void _navButtonHandle(
      {required int page, required String sortBy, required String orderBy}) {
    controller.page = 1;
    controller
        .getProducts(
            page: controller.page,
            limit: controller.limit,
            search: controller.rxSearch.value,
            categoryId: controller.rxCategory.value?.id,
            sortBy: sortBy,
            orderBy: orderBy)
        .then((res) {
      controller.rxListProduct.value = res.data ?? [];
    });
  }

  Widget _sortedProductList() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: MyGridView(
        shimmerLoading: controller.rxShimmerLoading.value,
        listProduct: controller.rxListProduct,
        listLength: controller.rxListProduct.length,
        scrollController: controller.scrollController,
        paddingVertical: 8,
        paddingHorizontal: 16,
      ),
    );
  }
}
