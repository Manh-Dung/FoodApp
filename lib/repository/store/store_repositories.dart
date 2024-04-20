import 'package:dio/dio.dart';
import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/networking/api.dart';
import 'package:ints/models/store/store.dart';

import '../../base/networking/constants/endpoints.dart';

class StoreRepositories {
  late ApiService _service;

  StoreRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Options _options = Options(
    headers: {"requiresToken": false},
  );

  Future<Store> getStoreById(num storeId) async {
    try {
      var res = await _service.get(Endpoints.stores + "/" + storeId.toString(),
          options: _options);
      return Store.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<APIResponsePaging<List<Store>>> getStores(
      {num? limit,
      num? page,
      num? sortBy,
      num? orderBy,
      String? search}) async {
    try {
      var res = await _service.get(
        Endpoints.stores,
        queryParameters: {
          "limit": limit,
          "page": page,
          "sort_by": sortBy,
          "order_by": orderBy,
          "search": search
        },
        options: _options,
      );

      return APIResponsePaging.fromList(
          res,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Store.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<APIResponsePaging<List<Store>>> getNearByStores(
      {num? limit,
      num? page,
      num? sortBy,
      num? orderBy,
      String? search}) async {
    try {
      var res = await _service.get(
        Endpoints.stores + "/nearby",
        queryParameters: {
          "limit": limit,
          "page": page,
          "sort_by": sortBy,
          "order_by": orderBy,
          "search": search
        },
      );

      return APIResponsePaging.fromList(
          res,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Store.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
