import 'package:ints/base/base_controller.dart';

import '../../base/api_response_paging.dart';
import '../../models/cart/cart.dart';
import '../../models/order/order.dart';
import '../../models/product/product.dart';
import '../../models/store/store.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController());
  }
}

class OrderDetailController extends BaseController {
  Rxn<Order> rxOrder = Rxn<Order>();
  RxBool rxIsLoading = RxBool(true);
  RxList<Product> rxListProduct = RxList();
  Rxn<Store> rxStore = Rxn();
  RxnNum rxTotalPoint = RxnNum(0);

  num page = 1;

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();
    var order = Get.arguments?["order"];
    if (order != null) {
      rxOrder.value = order;
      for (CartItems item in order.cartItems ?? []) {
        rxTotalPoint.value = (item.price?.point ?? 0) * (item.quantity ?? 1);
      }
    }

    getProducts(limit: 8, page: page).then((res) {
      rxListProduct.value = res.data ?? [];
      rxIsLoading.value = false;
    });
  }

  @override
  void onRefresh() {
    super.onRefresh();
    page = 1;
    getProducts(limit: 8, page: page).then((res) {
      rxListProduct.value = res.data ?? [];
      rxIsLoading.value = false;
    });
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

  Future<Product> getProductById({required num id}) async {
    try {
      var res = await productRepositories.getProductById(id: id);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get product');
    }
  }
}
