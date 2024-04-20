import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../base/api_response_paging.dart';
import '../../base/networking/api.dart';
import '../../base/networking/constants/endpoints.dart';
import '../../models/feedback/feedback_user.dart';
import '../../models/feedback/post_feedback.dart';

class FeedbackRepositories {
  late ApiService _service;

  FeedbackRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponsePaging<List<FeedbackUser>>> getFeedbacks(
      {String? orderBy, String? sortBy, String? search, num? limit, num? page}) async {
    try {
      final response = await _service.get(
        Endpoints.feedback_user,
        queryParameters: {
          'search': search,
          'limit': limit,
          'page': page,
          "order_by": orderBy,
          "sort_by": sortBy
        },
      );
      return APIResponsePaging.fromList(
          response,
          (json) =>
              APIResponsePaging.fromLJsonListT(json, (json2) => FeedbackUser.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<APIResponsePaging<List<FeedbackUser>>> getNoFeedbacks(
      {String? search, num? limit, num? page}) async {
    try {
      final response = await _service.get(
        Endpoints.no_feedback_user,
        queryParameters: {
          'search': search,
          'limit': limit,
          'page': page,
        },
      );
      return APIResponsePaging.fromList(
          response,
          (json) =>
              APIResponsePaging.fromLJsonListT(json, (json2) => FeedbackUser.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> postSingleFeedback(
      {required num productId,
      required num priceId,
      required List<String?> images,
      required num rating,
      required String content}) async {
    try {
      await _service.post(Endpoints.feedback, data: {
        "product_id": productId,
        "price_id": priceId,
        "image": images,
        "rating": rating,
        "content": content
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> postMultiFeedback({required List<PostFeedback> feedbacks}) async {
    try {
      await _service.post(Endpoints.feedback_multi,
          data: {"feedbacks": feedbacks.map((e) => e.toJson()).toList()});
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateFeedback(
      {required num feedbackId,
      required RxList<String?> images,
      required double rating,
      required String content,
      required num priceId}) async {
    try {
      await _service.put(Endpoints.feedback + "/$feedbackId",
          data: {"image": images, "rating": rating, "content": content, "price_id": priceId});
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
