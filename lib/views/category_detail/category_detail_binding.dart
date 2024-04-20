import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/category/category.dart';

import '../../base/api_response_paging.dart';
import '../../models/product/product.dart';

class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailController());
  }
}

class CategoryDetailController extends BaseController
    with GetSingleTickerProviderStateMixin {
  Rxn<Category> rxCategory = Rxn(Get.arguments?['category']);
  Rx<bool> rxShimmerLoading = Rx(true);

  RxList<Product> rxListProduct = RxList();
  RxList<String> rxTabNameList = RxList([
    "Hàng mới",
    "Bán chạy",
    "Giá thấp",
    "Giá cao",
  ]);

  List<List<String>> sortOptions = [
    ['created_at', 'DESC'],
    ['vote', 'DESC'],
    ['price', 'ASC'],
    ['price', 'DESC'],
  ];

  RxnString rxSearch = RxnString();

  late final TabController tabController =
      TabController(length: rxTabNameList.length, vsync: this);
  num page = 1;
  final num limit = 8;

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();

    var searchKey = Get.arguments?['searchKey'];
    if (searchKey != null) {
      rxSearch.value = searchKey;
    }

    getProducts(
            categoryId: rxCategory.value?.id,
            page: page,
            limit: limit,
            search: rxSearch.value)
        .then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });
  }

  @override
  onLoadMore() async {
    super.onLoadMore();
    page++;
    showLoadingDialog();
    await getProducts(
            categoryId: rxCategory.value?.id,
            page: page,
            limit: limit,
            search: rxSearch.value,
            sortBy: sortOptions[tabController.index][0],
            orderBy: sortOptions[tabController.index][1])
        .then((res) {
      rxListProduct.addAll(res.data ?? []);
    });
    hideDialog();
  }

  @override
  onRefresh() async {
    super.onRefresh();
    showLoadingDialog();
    page = 1;

    await getProducts(
            categoryId: rxCategory.value?.id,
            page: page,
            limit: limit,
            search: rxSearch.value,
            sortBy: sortOptions[tabController.index][0],
            orderBy: sortOptions[tabController.index][1])
        .then((res) {
      rxListProduct.value = res.data ?? [];
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
}
