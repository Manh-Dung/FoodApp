import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../../base/api_response_paging.dart';
import '../../models/product/product.dart';

class FlashSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlashSaleController());
  }
}

class FlashSaleController extends BaseController
    with GetSingleTickerProviderStateMixin {
  Rx<bool> rxShimmerLoading = Rx(true);

  Rx<int> currentPage = Rx(0);
  RxList<Product> rxListProduct = RxList();
  RxList<String> rxTabNameList = RxList([
    "12:00",
    "15:00",
    "17:00",
    "19:00",
  ]);
  late final TabController tabController;

  RxNum rxPage = RxNum(1);
  final num limit = 8;

  RxInt rxHour = RxInt(1);
  RxInt rxMinute = RxInt(0);
  RxInt rxSecond = RxInt(0);

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();

    getProducts(page: rxPage.value, limit: limit).then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });

    tabController = TabController(length: rxTabNameList.length, vsync: this);
    _tabListener();

    _startTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  onLoadMore() async {
    ++rxPage.value;
    showLoadingDialog();
    await getProducts(page: rxPage.value, limit: limit).then((res) {
      rxListProduct.addAll(res.data ?? []);
      update();
    });
    hideDialog();
    super.onLoadMore();
  }

  @override
  onRefresh() async {
    super.onRefresh();
    showLoadingDialog();
    rxPage.value = 1;
    rxListProduct.clear();

    await getProducts(page: rxPage.value, limit: limit).then((res) {
      rxListProduct.value = res.data ?? [];
      update();
    });

    hideDialog();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
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

  _tabListener() {
    tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!tabController.indexIsChanging) {
      currentPage.value = tabController.index;
    }
  }

  Future<void> _startTimer() async {
    await Timer.periodic(Duration(seconds: 1), (timer) {
      if (rxSecond.value > 0) {
        rxSecond.value--;
      } else {
        rxSecond.value = 59;
        if (rxMinute.value > 0) {
          rxMinute.value--;
        } else {
          rxMinute.value = 59;
          if (rxHour.value > 0) {
            rxHour.value--;
          }
        }
      }
    });
  }
}
