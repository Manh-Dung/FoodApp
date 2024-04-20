import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/favorite/favorite.dart';
import 'package:ints/models/store/store.dart';
import '../../base/api_response_paging.dart';
import '../home/home_binding.dart';

class FavoriteStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteStoreController());
  }
}

class FavoriteStoreController extends BaseController {
  Rx<bool> rxShimmerLoading = Rx(true);
  RxList<Favorite> rxListFavoriteStore = RxList();
  final ScrollController scrollController = ScrollController();
  Rx<bool> isFavoriteShop = RxBool(true);
  RxList<bool> isBeingEdited = RxList();

  final HomeController homeController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getAllFavoriteStore(limit: 5).then((res) {
      rxListFavoriteStore.value = res.data ?? [];
      rxShimmerLoading.value = false;
      isBeingEdited = RxList.filled(rxListFavoriteStore.length, true);
    });
  }

  Future<APIResponsePaging<List<Favorite>>> getAllFavoriteStore({
    num? page,
    num? limit,
  }) async {
    try {
      var res = await favoriteRepositories.getAllFavoriteStore(
        limit: limit,
        page: page,
      );

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get favorite store list');
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

  void loadMoreFavoriteStores() {
    if (rxShimmerLoading.value) return;

    if (rxListFavoriteStore.length % 5 != 0) return;

    int nextPage = rxListFavoriteStore.length ~/ 5 + 1;

    rxShimmerLoading.value = true;

    getAllFavoriteStore(page: nextPage, limit: 5).then((res) {
      rxListFavoriteStore.addAll(res.data ?? []);

      rxShimmerLoading.value = false;
    }).catchError((error) {
      print("Error loading more favorite stores: $error");
      rxShimmerLoading.value = false;
    });
  }

  Future<void> addFavoriteStatus(num storeId) async {
    showLoadingDialog();
    try {
      await favoriteRepositories.addFavoriteStatus(storeId: storeId);
      isFavoriteShop.value = true;
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
      isFavoriteShop.value = false;
      hideDialog();

      update();
      handleSuccessStringShowToast(
          message: 'Cập nhật trạng thái yêu thích cửa hàng thành công');
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  void updateEditStatus(int index) {
    isBeingEdited[index] = !isBeingEdited[index];
    homeController.onRefresh();
  }
}
