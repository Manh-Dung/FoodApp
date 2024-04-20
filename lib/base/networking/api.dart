import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/x_utils/connection_util.dart';
import 'package:ints/x_utils/failure.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../views/app/app_controller.dart';
import '../../x_utils/get_storage_util.dart';
import 'constants/endpoints.dart';
import 'interceptors/app_interceptors.dart';

class ApiService {
  factory ApiService({bool isLogout = false}) =>
      ApiService._internal(isLogout: isLogout);

  late Dio _dio;

  ApiService._internal({bool isLogout = false}) {
    BaseOptions options = new BaseOptions(
      baseUrl: MyConfig.BASE_URL,
      connectTimeout: Duration(milliseconds: MyConfig.CONNECTION_TIMEOUT),
      receiveTimeout: Duration(milliseconds: MyConfig.RECEIVE_TIMEOUT),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    _dio = new Dio(options);
    // if (Platform.isAndroid) {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    // }
    // _dio.interceptors.add(AppInterceptors(_dio));
    _dio.interceptors.add(
      queuedInterceptorsWrapper(),
    );
    CookieJar cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    bool _isConnected = await ConnectionUtil.checkConnection();
    if (!_isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.get(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print(response.data);
      response.toString();
      return response.data;
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        await _handleExpiredSession(e);
      }
      print((e as DioError).response);
      print((e as DioError).error);
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    bool _isConnected = await ConnectionUtil.checkConnection();
    if (!_isConnected) throw NetworkException();
    try {
      print(uri);
      print(data);
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        await _handleExpiredSession(e);
      }
      print((e as DioError).response);
      print((e as DioError).error);
      throw e;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    bool _isConnected = await ConnectionUtil.checkConnection();
    if (!_isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      response.realUri;
      return response.data;
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        await _handleExpiredSession(e);
      }
      throw e;
    }
  }

  // Patch:---------------------------------------------------------------------
  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    bool _isConnected = await ConnectionUtil.checkConnection();
    if (!_isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      response.realUri;
      return response.data;
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        await _handleExpiredSession(e);
      }
      throw e;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    bool _isConnected = await ConnectionUtil.checkConnection();
    if (!_isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      response.realUri;
      return response.data;
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        await _handleExpiredSession(e);
      }
      throw e;
    }
  }

  // Download:------------------------------------------------------------------
  Future<dynamic> download(String uri, savePath,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader}) async {
    try {
      bool _isConnected = await ConnectionUtil.checkConnection();
      if (!_isConnected) throw NetworkException();
      final response = await _dio.download(uri, savePath,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          deleteOnError: deleteOnError,
          lengthHeader: lengthHeader);
      return response.data;
    } catch (e) {
      print(e.toString());
      if (e is DioError) {
        await _handleExpiredSession(e);
      }
      throw e;
    }
  }

  _handleExpiredSession(DioError e) async {
    print("Expired Session Error is occurred");
  }

  QueuedInterceptorsWrapper queuedInterceptorsWrapper() {
    return QueuedInterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
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
        var accessToken = ShareStorage.storage.read(MyConfig.ACCESS_TOKEN_KEY);
        var refreshToken =
            ShareStorage.storage.read(MyConfig.REFRESH_TOKEN_KEY);

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
        final accessTokenHasExpired = JwtDecoder.isExpired(accessToken);
        final refreshTokenHasExpired = JwtDecoder.isExpired(refreshToken);

        var _refreshed = true;

        ///TODO: remove comment after change end point
        if (refreshTokenHasExpired && accessTokenHasExpired) {
          _performLogout(_dio);

          // create custom dio error
          options.extra["tokenErrorType"] =
              TokenErrorType.refreshTokenHasExpired;
          final error =
              DioError(requestOptions: options, type: DioErrorType.cancel);

          return handler.reject(error);
        }

//     // TODO: reopen when need regenerate accessToken from refreshToken
        else if (accessTokenHasExpired) {
          // regenerate access token
          // _dio.interceptors.requestLock.lock();
          _refreshed = await _regenerateAccessToken();
          // _dio.interceptors.requestLock.unlock();
        }
//
        if (_refreshed) {
          accessToken = ShareStorage.storage.read(MyConfig.ACCESS_TOKEN_KEY);
          refreshToken = ShareStorage.storage.read(MyConfig.REFRESH_TOKEN_KEY);
          // add access token to the request header
          options.headers["Authorization"] = "Bearer $accessToken";
          return handler.next(options);
        } else {
          // create custom dio error
          options.extra["tokenErrorType"] =
              TokenErrorType.failedToRegenerateAccessToken;
          final error =
              DioError(requestOptions: options, type: DioErrorType.unknown);
          _performLogout(_dio);
          handler.reject(error);
        }
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioError err, handler) {
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

        handler.next(err);
      },
    );
  }

  /// return true if it is successfully regenerate the access token
  Future<bool> _regenerateAccessToken() async {
    try {
      var dio = Dio(BaseOptions(
        baseUrl: MyConfig.BASE_URL,
        connectTimeout: Duration(milliseconds: MyConfig.CONNECTION_TIMEOUT),
        receiveTimeout: Duration(milliseconds: MyConfig.RECEIVE_TIMEOUT),
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
      )); // should create new dio instance because the request interceptor is being locked
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      // get refresh token from local storage
      final refreshToken =
          ShareStorage.storage.read(MyConfig.REFRESH_TOKEN_KEY);
      var data = {
        'grant_type': "refresh_token",
        'client_id': "web-client",
        'scope': "openid",
        'refresh_token': refreshToken
      };
      // make request to server to get the new access token from server using refresh token
      final response = await dio.post(
        "${Endpoints.refreshToken}", data: data,
        // TODO: Change refresh api path
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response.data["access_token"]; //
        final newRefreshToken = response
            .data["refresh_token"]; // parse data based on your JSON structure
        await ShareStorage.storage
            .write(MyConfig.ACCESS_TOKEN_KEY, newAccessToken);
        await ShareStorage.storage
            .write(MyConfig.REFRESH_TOKEN_KEY, newRefreshToken);

        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // it means your refresh token no longer valid now, it may be revoked by the backend
        _performLogout(_dio);
        return false;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _performLogout(Dio dio) async {
    // _dio.interceptors.requestLock.clear();
    // _dio.interceptors.requestLock.lock();

    // remove token from local storage
    AppController appController = Get.find();
    appController.isLogin.value = false;

    await ShareStorage.storage.erase();
    // ShareStorage.storage.write(MyConfig.ACCESS_TOKEN_KEY, true);
    // while (GET.Get.currentRoute != RouterName.main_home) GET.Get.back();
    // if (GET.Get.isRegistered<MainController>()) {
    //   final MainController _mainController = GET.Get.find();
    //   _mainController.rxIsLogin(false);
    //   _mainController.rxIndexTab(0);
    //   _mainController.tabController.index = 0;
    // }
    // back to login page without using context

    ///Open when have Login screen
    // if (GET.Get.isRegistered<LoginController>()) {
    //   while (GET.Get.currentRoute != RouterName.login) {
    //     GET.Get.back();
    //   }
    // } else if (GET.Get.currentRoute != RouterName.login) {
    //   GET.Get.offAllNamed(RouterName.login);
    // }

    // if (!(GET.Get.isDialogOpen ?? true))
    //   GET.Get.dialog(DialogErrorWidget(
    //       message: "The login session has expired\nplease login again."));
    ///-----

    // _dio.interceptors.requestLock.unlock();
  }
}
