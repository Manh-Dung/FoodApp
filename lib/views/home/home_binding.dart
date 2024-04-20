import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/favorite/favorite.dart';

import '../../base/cart_api_response_paging.dart';
import '../../models/address/address.dart';
import '../../models/cart/cart.dart';
import '../../models/product/product.dart';
import '../../models/store/store.dart';
import '../app/app_controller.dart';
import '../cart/cart_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CartController());
  }
}

class HomeController extends BaseController
    with GetSingleTickerProviderStateMixin {
  AppController appController = Get.find();

  RxInt currentPage = RxInt(0);
  RxInt currentBanner = RxInt(0);
  RxList<Cart> rxListCart = RxList();
  RxBool checkSelect = RxBool(false);
  Rx<bool> rxShimmerLoading = Rx(true);
  RxInt rxCartCount = RxInt(0);

  CarouselController carouselController = CarouselController();
  late TabController tabController;

  // RxList<Category> rxListCategory = RxList();
  RxList<Product> rxListProduct = RxList();
  RxList<Product> rxListNearByProduct = RxList();
  RxList<Store> rxListStore = RxList();
  RxList<Favorite> rxListFavorite = RxList();

  RxInt rxHour = RxInt(1);
  RxInt rxMinute = RxInt(0);
  RxInt rxSecond = RxInt(0);

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();

    tabController = TabController(length: 5, vsync: this);
    _startTimer();
    // getCategories().then((res) {
    //   rxListCategory.value = res.data ?? [];
    // });
    fetchNearbyProducts();
  }

  @override
  void onReady() {
    super.onReady();

    getStores().then((res) {
      rxListStore.value = res.data ?? [];
    });

    getProducts(limit: 8).then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });

    if (appController.isLogin.value) {
      getCarts().then((res) {
        rxListCart.value = res.data ?? [];
        rxCartCount.value = rxListCart.length;
      });
      getAllFavoriteStore().then((res) {
        rxListFavorite.value = res.data ?? [];
      });
    }
  }

  @override
  onRefresh() async {
    super.onRefresh();
    showLoadingDialog();

    rxShimmerLoading.value = true;

    await getStores().then((res) {
      rxListStore.value = res.data ?? [];
    });

    await getProducts().then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });

    if (appController.isLogin.value) {
      await getCarts().then((res) {
        rxListCart.value = res.data ?? [];
        rxCartCount.value = rxListCart.length;
      });

      await getAllFavoriteStore().then((res) {
        rxListFavorite.value = res.data ?? [];
      });
      await fetchNearbyProducts();
      update();
      hideDialog();
    }

    hideDialog();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // Future<APIResponsePaging<List<Category>>> getCategories(
  //     {int? limit, int? page, String? sortBy, String? orderBy, String? search}) async {
  //   try {
  //     var res = await categoryRepositories.getCategories(
  //         limit: limit, page: page, sortBy: sortBy, orderBy: orderBy, search: search);
  //
  //     return res;
  //   } catch (e) {
  //     handleErr(e);
  //     throw Exception('Failed to get categories');
  //   }
  // }

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

  num get totalPrice {
    num sum = 0;
    for (var item in rxListCart) {
      for (CartItems cartItem in (item.cartItems ?? [])) {
        sum = (cartItem.quantity ?? 0) * (cartItem.priceAtPurchase ?? 0);
      }
    }
    return sum;
  }

  Future<bool> getUserInfor() async {
    try {
      var res = await authRepositories.getUserInfor();
      appController.rxUser.value = res;
      return true;
    } catch (e) {
      handleErr(e);
      return false;
    }
  }

  Future<Address> getDefaultAddress() async {
    try {
      var res = await addressRepositories.getDefaultAddress();
      return res;
    } catch (e) {
      throw Exception('Failed to get default address');
    }
  }

  Future<APIResponsePaging<List<Store>>> getNearByStore(
      {num? limit,
      num? page,
      num? sortBy,
      num? orderBy,
      String? search}) async {
    try {
      var res = await storeRepositories.getNearByStores(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search);
      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get nearby stores');
    }
  }

  Future<void> fetchNearbyProducts() async {
    if (appController.isLogin.value) {
      var defaultAddress = await getDefaultAddress();
      if (defaultAddress.addressDetail != null) {
        var nearbyStore = await getNearByStore();
        var stores = (nearbyStore.data ?? [])
            .where((store) => (store.product?.length ?? 0) > 0)
            .toList();
        rxListNearByProduct.clear();
        for (var store in stores) {
          if (store.product != null && store.product!.isNotEmpty) {
            var product = store.product?[0];
            if (product != null) {
              rxListNearByProduct.add(product);
            }
          }
        }
      } else {
        rxListNearByProduct.clear();
      }
    }
  }

  Future<APIResponsePaging<List<Store>>> getStores(
      {num? limit,
      num? page,
      num? sortBy,
      num? orderBy,
      String? search}) async {
    try {
      var res = await storeRepositories.getStores(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get stores');
    }
  }

  Future<void> addFavorite({required num storeId}) async {
    showLoadingDialog();
    try {
      await favoriteRepositories.addFavoriteStatus(storeId: storeId);
      getAllFavoriteStore().then((res) {
        rxListFavorite.value = res.data ?? [];
      });
      getStores().then((res) {
        rxListStore.value = res.data ?? [];
      });
      hideDialog();
    } catch (e) {
      hideDialog();
      handleErr(e);
    }
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

  Future<void> removeFavorite({required num storeId}) async {
    showLoadingDialog();
    try {
      await favoriteRepositories.removeFavoriteShop(storeId: storeId);
      getAllFavoriteStore().then((res) {
        rxListFavorite.value = res.data ?? [];
      });
      getStores().then((res) {
        rxListStore.value = res.data ?? [];
      });
      hideDialog();
    } catch (e) {
      hideDialog();
      handleErr(e);
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
