import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as GET;
import 'package:ints/x_res/my_config.dart';
import 'package:ints/x_routes/routes.dart';
import 'package:ints/x_utils/get_storage_util.dart';

enum TokenErrorType {
  tokenNotFound,
  refreshTokenHasExpired,
  failedToRegenerateAccessToken,
  invalidAccessToken
}

class AppInterceptors extends QueuedInterceptorsWrapper {
  final Dio _dio;

  AppInterceptors(this._dio);

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("base_url")) {
      options.baseUrl = options.headers["base_url"];
      options.headers.remove("base_url");
    }

    if (options.headers.containsKey("requiresToken") &&
        options.headers["requiresToken"] == false) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.headers.remove("requiresToken"); //remove the auxiliary header
      return handler.next(options);
    }

    // get tokens from local storage, you can use Hive or flutter_secure_storage
    final accessToken = ShareStorage.storage.read(MyConfig.ACCESS_TOKEN_KEY);
    final refreshToken = ShareStorage.storage.read(MyConfig.REFRESH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      _performLogout(_dio);

      // create custom dio error
      options.extra["tokenErrorType"] = TokenErrorType
          .tokenNotFound; // I use enum type, you can chage it to string
      final error =
          DioError(requestOptions: options, type: DioErrorType.unknown);
      return handler.reject(error);
    }

    // check if tokens have already expired or not
    // I use jwt_decoder package
    // Note: ensure your tokens has "exp" claim
    // final accessTokenHasExpired = Jwt.isExpired(accessToken);
    // final refreshTokenHasExpired = Jwt.isExpired(refreshToken);

    var _refreshed = true;

    ///TODO: remove comment after change end point
    // if (refreshTokenHasExpired || accessTokenHasExpired) {
    //   _performLogout(_dio);
    //
    //   // create custom dio error
    //   options.extra["tokenErrorType"] = TokenErrorType.refreshTokenHasExpired;
    //   final error = DioError(requestOptions: options, type: DioErrorType.other);
    //
    //   return handler.reject(error);
    // }

//     // TODO: reopen when need regenerate accessToken from refreshToken
    // else if (accessTokenHasExpired) {
    //   // regenerate access token
    //   _dio.interceptors.requestLock.lock();
    //   _refreshed = await _regenerateAccessToken();
    //   _dio.interceptors.requestLock.unlock();
    // }
//
    if (_refreshed) {
      // add access token to the request header
      options.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(options);
    } else {
      // create custom dio error
      options.extra["tokenErrorType"] =
          TokenErrorType.failedToRegenerateAccessToken;
      final error =
          DioError(requestOptions: options, type: DioErrorType.unknown);
      return handler.reject(error);
    }
  }

  @override
  FutureOr<dynamic> onResponse(
      Response options, ResponseInterceptorHandler handler) async {
    // if (options.headers.value("verifyToken") != null) {
    //   //if the header is present, then compare it with the Shared Prefs key
    //   var verifyToken = secStore.secureRead("VerifyToken");
    //
    //   // if the value is the same as the header, continue with the request
    //   if (options.headers.value("verifyToken") == verifyToken) {
    //     return options;
    //   }
    // }

    // check token home
    handler.next(options);
    // return DioError(error: "User is no longer active", requestOptions: options.requestOptions);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (
        // err.response?.statusCode == 403 ||
        err.response?.statusCode == 401) {
      // for some reasons the token can be invalidated before it is expired by the backend.
      // then we should navigate the user back to login page

      _performLogout(_dio);

      // create custom dio error
      // err.type = DioErrorType.unknown;
      err.requestOptions.extra["tokenErrorType"] =
          TokenErrorType.invalidAccessToken;
    }

    return handler.next(err);
  }

//
  Future<void> _performLogout(Dio dio) async {
    // _dio.interceptors.requestLock.clear();
    // _dio.interceptors.requestLock.lock();

    // remove token from local storage
    await ShareStorage.storage.erase();
    ShareStorage.storage.write(MyConfig.ACCESS_TOKEN_KEY, true);
    while (GET.Get.currentRoute != RouterName.home) GET.Get.back();
    // if (GET.Get.isRegistered<MainController>()) {
    //   final MainController _mainController = GET.Get.find();
    //   _mainController.rxIsLogin(false);
    //   _mainController.rxIndexTab(0);
    //   _mainController.tabController.index = 0;
    // }
    // back to login page without using context
    // if (GET.Get.currentRoute != RouterName.login)
    //   GET.Get.offAllNamed(RouterName.login);

    // _dio.interceptors.requestLock.unlock();
  }
}
