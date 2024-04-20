import 'package:ints/base/base_controller.dart';

import '../../base/api_response_paging.dart';
import '../../models/cart/cart.dart';
import '../../models/order/order.dart';
import '../../models/store/store.dart';
import '../../models/product/product.dart';

class SearchOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchOrderController());
  }
}

class SearchOrderController extends BaseController {
  RxList<Order> rxListOrder = RxList();
  Rx<String> rxSearchValue = RxString("");
  Rxn<Product> rxProduct = Rxn();
  Rxn<Store> rxStore = Rxn();
  num page = 1;
  num limit = 3;

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();

    getOrders(page: page, limit: limit).then((res) {
      rxListOrder.value = res.data ?? [];
    });
  }

  @override
  onLoadMore() {
    page++;
    getOrders(page: page, limit: limit).then((res) {
      rxListOrder.addAll(res.data ?? []);
    });
  }

  @override
  onRefresh() async {
    page = 1;
    await getOrders(page: page, limit: limit).then((res) {
      rxListOrder.addAll(res.data ?? []);
    });
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
