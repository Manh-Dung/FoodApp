import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../../base/api_response_paging.dart';
import '../../models/cart/cart.dart';
import '../../models/order/order.dart';
import '../../models/store/store.dart';
import '../../models/product/product.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}

class OrderController extends BaseController
    with GetSingleTickerProviderStateMixin {
  RxList<String> rxTabNameList = RxList([
    "Tất cả",
    "Chờ xác nhận",
    "Xác nhận",
    "Đang giao hàng",
    "Đã giao hàng",
    "Đã hủy",
  ]);

  RxList<String> rxTabStatusList = RxList([
    "",
    "awaiting_confirmation",
    "Confirm",
    "Deliver",
    "Delivered",
    "Cancel",
  ]);

  late final TabController tabController;
  final TextEditingController orderSearchController = TextEditingController();

  RxList<Order> rxListOrder = RxList();
  Rxn<Product> rxProduct = Rxn();
  Rxn<Store> rxStore = Rxn();
  RxnString rxCreatedAt = RxnString();
  RxInt rxPage = RxInt(1);
  RxInt rxLimit = RxInt(4);
  RxInt rxTotal = RxInt(0);

  @override
  void onInit() {
    tabController = TabController(length: rxTabNameList.length, vsync: this);
    withScrollController = true;
    super.onInit();

    getOrders(page: rxPage.value, limit: rxLimit.value).then((res) {
      rxListOrder.value = res.data ?? [];
      rxTotal.value = (res.total ?? 0).toInt();
    });
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    rxPage.value = 1;
    showLoadingDialog();
    await getOrders(
            page: rxPage.value,
            limit: rxLimit.value,
            status: rxTabStatusList[tabController.index])
        .then((res) {
      rxListOrder.value = res.data ?? [];
    });
    hideDialog();
  }

  @override
  void onLoadMore() async {
    super.onLoadMore();
    rxPage.value++;
    showLoadingDialog();
    await getOrders(
            page: rxPage.value,
            limit: rxLimit.value,
            status: rxTabStatusList[tabController.index])
        .then((res) {
      rxListOrder.addAll(res.data ?? []);
    });
    hideDialog();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
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

  Future<void> cancelOrder({required num orderId}) async {
    showLoadingDialog();
    try {
      await orderRepositories.cancelOrder(orderId: orderId);
      getOrders(
              page: rxPage.value,
              limit: rxLimit.value,
              status: rxTabStatusList[tabController.index])
          .then((res) {
        rxListOrder.value = res.data ?? [];
      });
      hideDialog();
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  Future<Product> getProductById({required num id}) async {
    try {
      var res = await productRepositories.getProductById(id: id);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product');
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

  Future<Order> getOrderById({required num id}) async {
    try {
      var res = await orderRepositories.getOrderById(id: id);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get order');
    }
  }
}
