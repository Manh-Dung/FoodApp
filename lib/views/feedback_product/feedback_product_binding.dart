import 'package:flutter/cupertino.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/product/product.dart';

import '../../base/cart_api_response_paging.dart';
import '../../models/address/address.dart';
import '../../models/cart/cart.dart';
import '../../models/feedback/feedback_product.dart';
import '../../models/product/product_option.dart';

class FeedBackProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedBackProductController());
  }
}

class FeedBackProductController extends BaseController {
  Rxn<Product> rxProduct = Rxn();
  RxList<FeedbackProduct> rxListFeedBackProduct = RxList();
  RxBool rxIsLoading = RxBool(true);
  TextEditingController quantityController = TextEditingController(text: "0");
  RxList<ProductOption> rxProductOption = RxList();
  RxList<Cart> rxListCart = RxList();
  Rxn<Address> rxAddressDefault = Rxn();
  RxList<Cart> rxListTransferCart = RxList();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      rxListFeedBackProduct.value = Get.arguments["feedbackProductList"];
      rxProduct.value = Get.arguments["product"];
      rxIsLoading.value = false;
    }

    getProductOptionByProductId(productId: rxProduct.value?.id ?? 0).then((res) {
      rxProductOption.value = res;
    });
  }

  Future<List<ProductOption>> getProductOptionByProductId({required num? productId}) async {
    try {
      var res = await productRepositories.getProductOptionByProductId(productId: productId);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product option');
    }
  }

  Future<void> addToCart(num priceId) async {
    showLoadingDialog();
    try {
      await cartRepositories.addCartItem(
          productId: rxProduct.value?.id ?? 0,
          quantity: int.parse(quantityController.text),
          priceId: priceId);
      hideDialog();

      getCarts().then((res) {
        rxListCart.value = res.data ?? [];
      });
      Get.back();
      handleSuccessStringShowToast(message: "Thêm vào giỏ hàng thành công");
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  Future<void> buyNow(priceId) async {
    showLoadingDialog();

    try {
      var addressRes = await addressRepositories.getDefaultAddress();
      rxAddressDefault.value = addressRes;
      final orderItem = await cartRepositories.addCartItem(
          productId: rxProduct.value?.id ?? 0,
          quantity: int.parse(quantityController.text),
          priceId: priceId);
      hideDialog();

      if (rxAddressDefault.value == null) {
        Get.toNamed(RouterName.create_address, arguments: {"listCart": rxListTransferCart});
      } else {
        Get.toNamed(RouterName.checkout, arguments: {
          "addressDefault": rxAddressDefault.value,
          "orderItem": orderItem,
        });
      }
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  Future<CartAPIResponsePaging<List<Cart>>> getCarts(
      {int? limit, int? page, String? sortBy, String? orderBy, String? search}) async {
    try {
      var res = await cartRepositories.getCarts(
          limit: limit, page: page, sortBy: sortBy, orderBy: orderBy, search: search);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get carts');
    }
  }
}
