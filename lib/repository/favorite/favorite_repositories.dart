import 'package:ints/base/networking/api.dart';
import 'package:ints/base/networking/constants/endpoints.dart';

import '../../base/api_response_paging.dart';
import '../../models/favorite/favorite.dart';
import '../../x_utils/api_error_util.dart';

class FavoriteRepositories {
  late ApiService _service;

  FavoriteRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<void> addFavoriteStatus({required num storeId}) async {
    try {
      await _service.post(
        Endpoints.add_favorite_store,
        data: {"store_id": storeId},
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<APIResponsePaging<List<Favorite>>> getAllFavoriteStore({
    num? page,
    num? limit,
  }) async {
    try {
      var res = await _service.get(Endpoints.favoriteStores, queryParameters: {
        "page": page,
        "limit": limit,
      });
      return APIResponsePaging.fromList(
          res,
              (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Favorite.fromJson(json2)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }



  Future<bool> checkIsFavoriteStore(num storeId) async {
    try {
      var res = await _service.get(Endpoints.checkIsfavoriteStore(storeId));
      final Map<String, dynamic> responseData = res as Map<String, dynamic>;
      final bool isLiked = responseData['store_id'] == storeId;

      return isLiked;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> removeFavoriteShop({required storeId}) async {
    try {
      await _service
          .delete(Endpoints.removefavoriteStore, data: {"store_id": storeId});
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw HttpErrorUtil.handleError(e);
    }
  }
}
