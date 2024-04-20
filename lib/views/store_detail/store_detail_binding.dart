import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/product/product.dart';

import '../../base/api_response_paging.dart';
import '../../models/store/store.dart';
import '../home/home_binding.dart';

class StoreDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreDetailController());
  }
}

class StoreDetailController extends BaseController
    with GetSingleTickerProviderStateMixin {
  Rx<Store> rxStore = Rx(Get.arguments['store']);
  Rx<bool> rxShimmerLoading = Rx(true);
  RxInt rxCurTab = RxInt(0);
  RxInt rxCurPage = RxInt(0);
  RxDouble rxBannerHeight = RxDouble(200);
  RxDouble rxOpacity = RxDouble(1);
  late final TabController tabController;
  Rx<int> currentPage = Rx(0);
  RxList<Product> rxListProduct = RxList();
  HomeController homeController = Get.find();

  RxList<String> rxTabNameList = RxList([
    "Sản phẩm",
    "Bán chạy",
  ]);

  late Rx<bool> isFavoriteStore = RxBool(false);
  num page = 1;

  @override
  void onInit() {
    withScrollController = true;

    super.onInit();
    checkFavoriteStore();

    tabController = TabController(length: 2, vsync: this);

    getProducts(page: page, limit: 8, storeId: rxStore.value.id).then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });
  }

  @override
  onLoadMore() async {
    super.onLoadMore();
    showLoadingDialog();
    page++;
    await getProducts(page: page, limit: 8, storeId: rxStore.value.id)
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
    await getProducts(page: page, limit: 8, storeId: rxStore.value.id)
        .then((res) {
      rxListProduct.value = res.data ?? [];
    });

    await checkFavoriteStore();
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

  Future<void> checkFavoriteStore() async {
    try {
      bool isFavorite = await favoriteRepositories
          .checkIsFavoriteStore(rxStore.value.id ?? 0);
      isFavoriteStore.value = isFavorite;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> addFavoriteStatus(num storeId) async {
    showLoadingDialog();
    try {
      await favoriteRepositories.addFavoriteStatus(storeId: storeId);
      isFavoriteStore.value = true;
      hideDialog();

      update();
      handleSuccessStringShowToast(
          message: 'Cập nhật trạng thái yêu thích cửa hàng thành công');
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  Future<void> removeFavoriteStatus(num storeId) async {
    showLoadingDialog();
    try {
      await favoriteRepositories.removeFavoriteShop(storeId: storeId);
      isFavoriteStore.value = false;

      hideDialog();

      update();
      handleSuccessStringShowToast(
          message: 'Cập nhật trạng thái yêu thích cửa hàng thành công');
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }
}
