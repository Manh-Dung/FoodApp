import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/cart/cart_binding.dart';
import 'package:ints/x_utils/widgets/my_list_view.dart';
import 'package:ints/views/product_detail/product_detail_binding.dart';
import 'package:ints/views/product_detail/widgets/banner_widget.dart';
import 'package:ints/views/product_detail/widgets/basic_infor_widget.dart';
import 'package:ints/views/product_detail/widgets/bottom_nav_bar.dart';
import 'package:ints/views/product_detail/widgets/detail_infor_widget.dart';
import 'package:ints/views/product_detail/widgets/feed_back_buyer.dart';
import 'package:ints/views/product_detail/widgets/float_btn.dart';
import 'package:ints/views/product_detail/widgets/product_detail_widget.dart';
import 'package:ints/views/product_detail/widgets/review_widget.dart';
import 'package:ints/views/product_detail/widgets/specification_widget.dart';
import 'package:ints/views/product_detail/widgets/store_infor_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/product/product.dart';
import '../../x_utils/widgets/my_grid_view.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailController controller = Get.find();
  final CartController cartController = Get.find();

  Product? product;
  List<String> listImage = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = Get.arguments["product"];
    if (arguments != null) {
      product = Product.fromJson(arguments);
      if (product?.image?.length != 0) {
        for (var item in product?.image ?? []) {
          listImage.add(item.path ?? "");
        }
      }
    }

    if (controller.appController.isLogin.value) {
      controller
          .getAllProductFeedbacks(limit: 3, productId: product?.id)
          .then((res) {
        controller.rxListFeedBackProduct.value = res.data ?? [];
      });
    }

    controller.getStoreById(product?.storeId ?? 0).then((res) {
      controller.rxStore.value = res;
      controller.rxShimmerLoading.value = false;
    });

    if (controller.appController.isLogin.value) {
      controller
          .getProductOptionByProductId(productId: product?.id ?? 0)
          .then((res) {
        controller.rxProductOption.value = res;
      });
    }
  }

  Future<void> addToCart(num priceId) async {
    controller.showLoadingDialog();
    try {
      await controller.cartRepositories.addCartItem(
          productId: product?.id ?? 0,
          quantity: int.parse(controller.quantityController.text),
          priceId: priceId);
      controller.hideDialog();

      controller.getCarts().then((res) {
        controller.rxListCart.value = res.data ?? [];
        controller.rxCartCount.value = controller.rxListCart.length;
      });
      Get.back();
      controller.handleSuccessStringShowToast(
          message: "Thêm vào giỏ hàng thành công");
    } catch (e) {
      controller.handleErr(e);
      controller.hideDialog();
    }
  }

  Future<void> buyNow(priceId) async {
    controller.showLoadingDialog();

    try {
      var addressRes = await controller.addressRepositories.getDefaultAddress();
      controller.rxAddressDefault.value = addressRes;
      final orderItem = await controller.cartRepositories.addCartItem(
          productId: product?.id ?? 0,
          quantity: int.parse(controller.quantityController.text),
          priceId: priceId);
      controller.hideDialog();

      if (controller.rxAddressDefault.value == null) {
        Get.toNamed(RouterName.create_address,
            arguments: {"listCart": controller.rxListTransferCart});
      } else {
        Get.toNamed(RouterName.checkout, arguments: {
          "addressDefault": controller.rxAddressDefault.value,
          "orderItem": orderItem,
        });
      }
    } catch (e) {
      controller.handleErr(e);
      controller.hideDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onRefresh();

          var arguments = await Get.arguments["product"];
          if (arguments != null) {
            product = await Product.fromJson(arguments);
            if (product?.image?.length != 0) {
              for (var item in product?.image ?? []) {
                listImage.add(item.path ?? "");
              }
            }
          }

          if (controller.appController.isLogin.value) {
            await controller
                .getAllProductFeedbacks(limit: 8, productId: product?.id)
                .then((res) {
              controller.rxListFeedBackProduct.value = res.data ?? [];
            });
          }

          await controller.getStoreById(product?.storeId ?? 0).then((res) {
            controller.rxStore.value = res;
          });

          await controller
              .getProductOptionByProductId(productId: product?.id ?? 0)
              .then((res) {
            controller.rxProductOption.value = res;
            controller.rxShimmerLoading.value = false;
          });
        },
        child: Stack(
          children: [
            Container(
              color: MyColor.BACKGROUND_COLOR,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => BannerWidget(
                          listBannerImg: listImage.length == 0
                              ? controller.rxListBannerImg
                              : listImage,
                          carouselController: controller.carouselController,
                          onChanged: (int value) {
                            controller.currentBannerIndex.value = value;
                          },
                          currentBannerIndex:
                              controller.currentBannerIndex.value,
                        )),
                    Obx(() => BasicInforWidget(
                          product: product,
                          shimmerLoading: controller.rxShimmerLoading.value,
                          totalReview: product?.vote ?? 0,
                          totalRating: product?.rating ?? 0,
                        )),
                    const SizedBox(height: 5),
                    Obx(() => StoreInforWidget(
                          store: controller.rxStore.value,
                          shimmerLoading: controller.rxShimmerLoading.value,
                        )),
                    const SizedBox(height: 5),
                    // controller.rxShimmerLoading.value
                    Obx(() => controller.rxShimmerLoading.value
                        ? Shimmer.fromColors(
                            child: _productsList(
                                title: "Sản phẩm nổi bật",
                                list: () {
                                  controller
                                      .getProducts(
                                          limit: 8, storeId: product?.storeId)
                                      .then((res) {
                                    controller.rxListProduct.value =
                                        res.data ?? [];
                                  });
                                },
                                onTap: () {
                                  Get.toNamed(RouterName.expanded_list_view,
                                      arguments: {
                                        'listProduct': controller.rxListProduct,
                                        "title": "Sản phẩm nổi bật"
                                      });
                                }),
                            baseColor: MyColor.SHIMMER_BASE_COLOR,
                            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR)
                        : _productsList(
                            title: "Sản phẩm nổi bật",
                            list: () {
                              controller
                                  .getProducts(
                                      limit: 8, storeId: product?.storeId)
                                  .then((res) {
                                controller.rxListProduct.value = res.data ?? [];
                              });
                            },
                            onTap: () {
                              Get.toNamed(RouterName.expanded_list_view,
                                  arguments: {
                                    'listProduct': controller.rxListProduct,
                                    "title": "Sản phẩm nổi bật"
                                  });
                            })),
                    const SizedBox(height: 5),
                    Obx(() => SpecificationWidget(
                          product: product,
                          shimmerLoading: controller.rxShimmerLoading.value,
                        )),
                    Divider(height: 0, color: MyColor.DIVIDER_COLOR),
                    Obx(() => DetailInforWidget(
                          description: product?.description ?? "",
                          isExpanded: controller.rxDescriptionExpanded.value,
                          onTap: () {
                            controller.rxDescriptionExpanded.value =
                                !controller.rxDescriptionExpanded.value;
                          },
                          shimmerLoading: controller.rxShimmerLoading.value,
                        )),
                    const SizedBox(height: 5),
                    Obx(() => Container(
                          child: ReviewWidget(
                            totalReview: product?.vote ?? 0,
                            totalRating: product?.rating ?? 0,
                            shimmerLoading: controller.rxShimmerLoading.value,
                            feedbackProductList:
                                controller.rxListFeedBackProduct,
                            product: product,
                          ),
                        )),
                    Container(
                        color: Colors.white,
                        child: Obx(() => ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  height: 1,
                                  color: MyColor.DIVIDER_COLOR,
                                  thickness: 1,
                                ),
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.rxListFeedBackProduct.length,
                            itemBuilder: (context, index) {
                              return Obx(() => ProductFeedback(
                                    isCheckShimmerLoading:
                                        controller.rxShimmerLoading.value,
                                    feedbackProduct:
                                        controller.rxListFeedBackProduct[index],
                                  ));
                            }))),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
                    const SizedBox(height: 5),
                    _sortedList()
                  ],
                ),
              ),
            ),
            FloatBtn(
                top: 60,
                left: 16,
                svgPicture: XR().svgImage.ic_back,
                onTap: () async {
                  Get.back(result: controller.rxCartCount.value);
                  cartController.onRefresh();
                }),
            FloatBtn(
                top: 60,
                right: 16,
                svgPicture: XR().svgImage.ic_menu,
                onTap: () {
                  Get.bottomSheet(
                      enableDrag: true,
                      useRootNavigator: false,
                      InkWell(
                        onTap: () {
                          while (Get.currentRoute != RouterName.home) {
                            Get.back();
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.keyboard_backspace_rounded,
                                  size: 30, color: Colors.black),
                              const SizedBox(width: 10),
                              Text("Trở lại trang chủ"),
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withOpacity(0.5));
                }),
            Obx(
              () => FloatBtn(
                top: 60,
                right: 60,
                svgPicture: XR().svgImage.ic_cart_product,
                onTap: () {
                  Get.toNamed(RouterName.cart);
                },
                cartLength: controller.rxCartCount.value,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        product: product,
        quantityController: controller.quantityController,
        productOption: controller.rxProductOption,
        onTap: (tag, priceId) => setState(() {
          tag == "Thêm vào giỏ hàng" ? addToCart(priceId) : buyNow(priceId);
        }),
      ),
    );
  }

  Widget _productsList(
      {required String title,
      VoidCallback? list,
      required VoidCallback onTap}) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: MyColor.TEXT_COLOR_NEW,
                        size: 12,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Obx(() => MyListView(
                listModelWidget: controller.rxListProduct,
                listLength: controller.rxListProduct.length,
                shimmerLoading: controller.rxShimmerLoading.value,
                itemBuilder: (modelWidget) {
                  return ProductDetailWidget(product: modelWidget);
                }))
          ],
        ));
  }

  Widget _sortedList() {
    return Obx(() => MyGridView(
          shimmerLoading: controller.rxShimmerLoading.value,
          listProduct: controller.rxListProduct,
          listLength: controller.rxListProduct.length,
          scrollController: controller.scrollController,
          paddingVertical: 0,
          paddingHorizontal: 16,
        ));
  }
}
