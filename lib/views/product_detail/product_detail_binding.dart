import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/app/app_controller.dart';
import 'package:ints/views/cart/cart_binding.dart';

import '../../base/api_response_paging.dart';
import '../../base/cart_api_response_paging.dart';
import '../../models/address/address.dart';
import '../../models/cart/cart.dart';
import '../../models/feedback/feedback_product.dart';
import '../../models/product/attribute_price.dart';
import '../../models/product/product_option.dart';
import '../../models/product/product_option_attribute.dart';
import '../../models/product/product.dart';
import '../../models/store/store.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
    Get.lazyPut(() => CartController());
  }
}

class ProductDetailController extends BaseController {
  AppController appController = Get.find();
  RxList<ProductOption> rxProductOption = RxList();

  Rxn<AttributePrice> attributePrice = Rxn();

  Rx<bool> rxDescriptionExpanded = Rx(false);
  Rx<int> currentBannerIndex = Rx(0);
  final CarouselController carouselController = CarouselController();
  Rx<bool> rxShimmerLoading = Rx(true);

  Rxn<Address> rxAddressDefault = Rxn();
  RxList<Cart> rxListTransferCart = RxList();
  RxList<Cart> rxListCart = RxList();
  RxNum rxOptionId = RxNum(0);
  RxInt rxCartCount = RxInt(0);
  TextEditingController quantityController = TextEditingController(text: "0");

  RxBool isProductOptionAttributeSeltected = RxBool(false);
  RxList<String> rxListBannerImg = RxList([
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
  ]);

  RxList<String> rxListImage = RxList();

  Rx<Store> rxStore = Rx(Store());
  RxList<Product> rxListProduct = RxList();
  RxList<FeedbackProduct> rxListFeedBackProduct = RxList();

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();

    getProducts(limit: 8).then((res) {
      rxListProduct.value = res.data ?? [];
    });

    if (appController.isLogin.value) {
      getCarts().then((res) {
        rxListCart.value = res.data ?? [];
        rxCartCount.value = rxListCart.length;
      });
    }
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    showLoadingDialog();
    await getProducts(limit: 8).then((res) {
      rxListProduct.value = res.data ?? [];
    });

    if (appController.isLogin.value) {
      await getCarts().then((res) {
        rxListCart.value = res.data ?? [];
        rxCartCount.value = rxListCart.length;
      });
    }
    hideDialog();
  }

  Future<APIResponsePaging<List<Product>>> getProducts(
      {num? limit,
      num? page,
      String? sortBy,
      String? orderBy,
      String? search,
      num? categoryId,
      num? storeId}) async {
    try {
      var res = await productRepositories.getProducts(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search,
          categoryId: categoryId,
          storeId: storeId);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get products');
    }
  }

  Future<Store> getStoreById(num storeId) async {
    try {
      var res = await storeRepositories.getStoreById(storeId);
      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get store');
    }
  }

  Future<CartAPIResponsePaging<List<Cart>>> getCarts(
      {int? limit,
      int? page,
      String? sortBy,
      String? orderBy,
      String? search}) async {
    try {
      var res = await cartRepositories.getCarts(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get carts');
    }
  }

  Future<APIResponsePaging<List<FeedbackProduct>>> getAllProductFeedbacks({
    num? productId,
    num? search,
    num? page,
    num? limit,
  }) async {
    try {
      var res = await feedbackProductRepositories.getAllProductFeedbacks(
        productId: productId,
        search: search,
        limit: limit,
        page: page,
      );

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product list_feedback list');
    }
  }

  Future<List<ProductOption>> getProductOptionByProductId(
      {required num? productId}) async {
    try {
      var res = await productRepositories.getProductOptionByProductId(
          productId: productId);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product option');
    }
  }

  Future<List<ProductOptionAttribute>> getProductOptionAttributeByOptionId(
      {required num optionId}) async {
    try {
      var res = await productRepositories.getProductOptionAttributeByOptionId(
          optionId: optionId);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product option ID');
    }
  }

  Future<AttributePrice> getProductOptionAttributePrice(
      {required num optionAttributeId}) async {
    try {
      var res = await productRepositories.getProductOptionAttributePrice(
          optionAttributeId: optionAttributeId);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product option attribute price');
    }
  }
}
