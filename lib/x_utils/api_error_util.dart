import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'failure.dart';

class HttpErrorUtil {
  // general methods:-----------------------------------------------------------
  static String handleError(dynamic error) {
    String errorDescription = "";
    if (error is DioException) {
      if (error.response != null && error.response?.data != null) {
        try {
          // var errorRs = ErrorGeneral.fromJson(error.response?.data as Map) ;
          var errorRs = error.response?.data['message'];

          if (error.response?.statusCode != null) {
            var apiErrors = error.response?.data['errors'];
            if (apiErrors != null) {
              if (apiErrors != null) {
                apiErrors.forEach((key, value) {
                  errorDescription +=
                      "${_convertErrorToVietnamese(error: value)}\n";
                });
              }
            }
          }

          return errorDescription.isNotEmpty ? errorDescription : errorRs ?? '';
        } catch (e) {}
      }
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Kết nối bị huỷ'.tr;
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Thời gian kết nối hết hạn'.tr;
          break;
        case DioExceptionType.unknown:
          errorDescription = 'Lỗi không xác định'.tr;
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Thời gian nhận hết hạn'.tr;
          break;
        case DioExceptionType.badResponse:
          errorDescription = 'Lỗi kết quả trả về'.tr;
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Thời gian yêu cầu hết hạn'.tr;
          break;
        case DioExceptionType.badCertificate:
          errorDescription = 'Lỗi kết quả trả về'.tr;
          break;
        case DioExceptionType.connectionError:
          errorDescription = 'Lỗi kết quả trả về'.tr;
          break;
      }
    } else if (error is NetworkException) {
      errorDescription = 'Lỗi kết nối'.tr;
    } else {
      errorDescription = 'Lỗi không xác định'.tr;
    }
    return errorDescription;
  }

  static String _convertErrorToVietnamese({required String error}) {
    String errorDescription = "";
    switch (error) {
      case "Incorrect Password":
        errorDescription = "Mật khẩu không chính xác";
        break;
      case "incorrectPassword":
        errorDescription = "Mật khẩu không chính xác";
        break;
      case "User Not Found":
        errorDescription = "Người dùng không tồn tại";
        break;
      case "Email Not Exists":
        errorDescription = "Email không tồn tại";
        break;
      case "Email already exists":
        errorDescription = "Email đã tồn tại";
        break;
      case "emailNotExists":
        errorDescription = "Email không tồn tại";
        break;
      case "Incorrect Old Password":
        errorDescription = "Mật khẩu cũ không chính xác";
        break;
      case "phone_number must be a phone number":
        errorDescription = "Số điện thoại không hợp lệ";
        break;
      case "Missing Old Password":
        errorDescription = "Thiếu mật khẩu cũ";
        break;
      case "Incorrect OTP":
        errorDescription = "OTP không chính xác";
        break;
      case "Mật khẩu ít nhất 6 kí tự":
        errorDescription = "Mật khẩu ít nhất 6 kí tự";
        break;
      default:
        errorDescription = error;
        break;
    }
    return errorDescription;
  }
}
