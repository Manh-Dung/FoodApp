import 'package:ints/base/networking/api.dart';
import 'package:ints/base/networking/constants/endpoints.dart';

import '../../base/cart_api_response_paging.dart';
import '../../models/cart/cart.dart';

class CartRepositories {
  late ApiService _service;

  CartRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<CartAPIResponsePaging<List<Cart>>> getCarts({
    int? limit,
    int? page,
    String? sortBy,
    String? orderBy,
    String? search,
    String? storeId,
  }) async {
    try {
      var res = await _service.get(Endpoints.carts, queryParameters: {
        "page": page,
        "limit": limit,
        "sort_by": sortBy,
        "order_by": orderBy,
        "search": search,
        "store_id": storeId,
      });
      return CartAPIResponsePaging.fromList(
          res,
          (json) => CartAPIResponsePaging.fromLJsonListT(
              json, (json2) => Cart.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Cart> getCartById({
    required num id,
  }) async {
    try {
      var res = await _service.get(Endpoints.carts + "/$id");
      return Cart.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<CartItems> updateQuantity(
      {required num quantity, required num id}) async {
    try {
      var res = await _service.patch(
        Endpoints.cart_items + "/$id",
        data: {"quantity": quantity},
      );
      return CartItems.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Cart> addCartItem(
      {required num productId,
      required num quantity,
      required num priceId}) async {
    try {
      var res = await _service.post(
        Endpoints.carts,
        data: {
          "product_id": productId,
          "quantity": quantity,
          "price_id": priceId
        },
      );
      return Cart.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<CartItems> getCartItemById({
    required num id,
  }) async {
    try {
      var res = await _service.get(Endpoints.carts + "/cart-items/$id");
      return CartItems.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> deleteCartItem({required num id}) async {
    try {
      await _service.delete(Endpoints.cart_item + "/$id");
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> deleteCart({required num id}) async {
    try {
      await _service.delete(Endpoints.carts + "/$id");
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
