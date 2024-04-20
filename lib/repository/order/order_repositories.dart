import 'package:ints/base/networking/api.dart';

import '../../base/api_response_paging.dart';
import '../../base/networking/constants/endpoints.dart';
import '../../models/order/order.dart';
import '../../x_utils/api_error_util.dart';

class OrderRepositories {
  late ApiService _service;

  OrderRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponsePaging<List<Order>>> getOrders(
      {num? limit,
      num? page,
      String? status,
      String? search,
      String? created_at}) async {
    try {
      final response = await _service.get(Endpoints.orders, queryParameters: {
        "page": page,
        "limit": limit,
        "status": status,
        "search": search,
        "created_at": created_at,
      });
      return APIResponsePaging.fromList(
          response,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Order.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future cancelOrder({required num orderId}) async {
    try {
      await _service.put(Endpoints.orders_cancel + "/$orderId");
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw e;
    }
  }

  Future postOrder(
      {required num addressId,
      required String note,
      required List<num> listCartId,
      required num point}) async {
    try {
      await _service.post(Endpoints.orders, data: {
        "cart_item_ids": listCartId,
        "address_id": addressId,
        "note": note,
        "point": point
      });
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw e;
    }
  }

  Future<APIResponsePaging<List<Order>>> getOrdersWait() async {
    try {
      final response = await _service.get(
        Endpoints.orders,
      );
      return APIResponsePaging.fromList(
          response,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Order.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Order> getOrderById({required num id}) async {
    try {
      final response = await _service.get(Endpoints.orders + "/$id");
      return Order.fromJson(response);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
