import 'package:dio/dio.dart';
import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/networking/api.dart';

import '../../base/networking/constants/endpoints.dart';
import '../../models/category/category.dart';

class CategoryRepositories {
  late ApiService _service;

  CategoryRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Options _options = Options(
    headers: {"requiresToken": false},
  );

  Future<APIResponsePaging<List<Category>>> getCategories(
      {int? limit,
      int? page,
      String? sortBy,
      String? orderBy,
      String? search}) async {
    try {
      var res = await _service
          .get(Endpoints.categories, options: _options, queryParameters: {
        "page": page,
        "limit": limit,
        "sort_by": sortBy,
        "order_by": orderBy,
        "search": search,
      });
      return APIResponsePaging.fromList(
          res,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Category.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
