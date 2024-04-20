import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../../base/api_response_paging.dart';
import '../../models/cart/cart.dart';
import '../../models/order/order.dart';
import '../../models/store/store.dart';
import '../../models/product/product.dart';

class OrderSuccessfullyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderSuccessfullyController());
  }
}

class OrderSuccessfullyController extends BaseController {
  RxList<Order> rxListOrder = RxList();
  Rx<bool> rxShimmerLoading = Rx(false);
  ScrollController scrollController1 = ScrollController();
  RxList<Product> rxListProduct = RxList();
  Rxn<Store> rxStore = Rxn();

  @override
  void onInit() {
    super.onInit();
    getOrders(status: "Confirm")
        .then((value) => rxListOrder.value = value.data ?? []);
    getProducts().then((value) => rxListProduct.value = value.data ?? []);
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

  Future<APIResponsePaging<List<Order>>> getOrders({
    num? limit,
    num? page,
    String? search,
    String? status,
    String? createAt,
  }) async {
    try {
      var res = await orderRepositories.getOrders(
          limit: limit,
          page: page,
          search: search,
          status: status,
          created_at: createAt);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get orders');
    }
  }

  Future<void> buyAgain(Order orders) async {
    showLoadingDialog();
    try {
      for (CartItems item in orders.cartItems ?? []) {
        await cartRepositories.addCartItem(
            productId: item.productId ?? 0,
            quantity: item.quantity ?? 0,
            priceId: item.priceId ?? 0);
      }

      hideDialog();
      Get.toNamed(RouterName.cart);
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  Future<Store> getStoreById({required num storeId}) async {
    showLoadingDialog();
    try {
      var res = await storeRepositories.getStoreById(storeId);

      hideDialog();
      return res;
    } catch (e) {
      hideDialog();
      handleErr(e);
      throw Exception('Failed to get store');
    }
  }
}
