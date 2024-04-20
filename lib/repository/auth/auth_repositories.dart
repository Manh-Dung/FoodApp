import 'package:dio/dio.dart';
import 'package:ints/base/networking/api.dart';
import 'package:ints/models/auth/login.dart';

import '../../base/networking/constants/endpoints.dart';
import '../../models/auth/user.dart';
import '../../x_utils/api_error_util.dart';

class AuthRepositories {
  late ApiService _service;

  AuthRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Options _options = Options(
    headers: {"requiresToken": false},
  );

  Future<Login> login({required String user, required String password}) async {
    try {
      var res = await _service.post(Endpoints.login_email,
          data: {"email": user, "password": password}, options: _options);
      return Login.fromJson(res);
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw e;
    }
  }

  Future<Login> loginPhone(
      {required String phone, required String password}) async {
    try {
      var res = await _service.post(Endpoints.login_phone,
          data: {"phone_number": phone, "password": password},
          options: _options);
      return Login.fromJson(res);
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw e;
    }
  }

  Future signUp(
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    try {
      await _service.post(
        Endpoints.register,
        data: {
          "fullName": fullName,
          "email": email,
          "phone_number": phone,
          "password": password,
        },
        options: _options,
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _service.post(
        Endpoints.forgotPassword,
        options: _options,
        data: {
          "email": email,
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> resetPassword(
      {required String email, String? otp, String? password}) async {
    try {
      await _service.post(
        Endpoints.resetPassword,
        data: {"email": email, "otp": otp, "password": password},
        options: _options,
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> sendOTP({required String email, String? otp}) async {
    try {
      await _service.post(
        Endpoints.otp,
        data: {"email": email, "otp": otp},
        options: _options,
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      await _service.post(Endpoints.logout);
    } catch (e) {
      print(HttpErrorUtil.handleError(e));
      throw e;
    }
  }

  Future<User> getUserInfor() async {
    try {
      var res = await _service.get(Endpoints.authMe);
      return User.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> changePassword(
      {required String oldPassword, required String password}) async {
    try {
      await _service.patch(Endpoints.change_password, data: {
        "oldPassword": oldPassword,
        "password": password,
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
