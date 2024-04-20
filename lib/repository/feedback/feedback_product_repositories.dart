import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/networking/api.dart';

import '../../base/networking/constants/endpoints.dart';
import '../../models/feedback/feedback_product.dart';

class FeedbackProductRepositories {
  late ApiService _service;

  FeedbackProductRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponsePaging<List<FeedbackProduct>>> getAllProductFeedbacks({
    num? productId,
    num? search,
    num? page,
    num? limit,
  }) async {
    try {
      var res = await _service.get(Endpoints.feedback, queryParameters: {
        "product_id": productId,
        "search": search,
        "page": page,
        "limit": limit,
      });
      return APIResponsePaging.fromList(
          res,
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => FeedbackProduct.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
