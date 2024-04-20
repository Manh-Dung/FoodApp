import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

class RegisterController extends BaseController {
  RxBool isCheck = RxBool(false);
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> signUp() async {
    showLoadingDialog();
    try {
      if (passwordTextController.text != confirmPasswordTextController.text) {
        hideDialog();
        handleErrorStringShowToast(error: "Mật khẩu không trùng khớp");
        return false;
      }

      await authRepositories.signUp(fullNameTextController.text, emailTextController.text,
          phoneTextController.text, passwordTextController.text);
      hideDialog();
      handleSuccessStringShowToast(message: "Đăng ký tài khoản thành công!");
      while (Get.currentRoute != RouterName.choose_login_signup) {
        Get.back();
      }
      return true;
    } catch (e) {
      handleErr(e);
      hideDialog();
      return false;
    }
  }
}
