import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/app/app_controller.dart';
import 'package:ints/views/home/home_binding.dart';

import '../../x_utils/get_storage_util.dart';

class AccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountSettingController());
    Get.lazyPut(() => HomeController());
  }
}

class AccountSettingController extends BaseController {
  AppController appController = Get.find();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reNewPasswordController = TextEditingController();
  late TabController tabController;
  RxInt currentPage = RxInt(0);
  final homeController = Get.find<HomeController>();

  Future<bool> changePassword() async {
    showLoadingDialog();

    try {
      if (await newPasswordController.text != reNewPasswordController.text) {
        hideDialog();
        handleErrorStringShowToast(error: "Mật khẩu không trùng khớp");
        return false;
      } else {
        await authRepositories.changePassword(
            oldPassword: oldPasswordController.text,
            password: newPasswordController.text);

        hideDialog();
      }

      return true;
    } catch (e) {
      handleErr(e);
      hideDialog();
      return false;
    }
  }

  Future<void> removeAccessToken() async {
    await ShareStorage.storage.remove(MyConfig.ACCESS_TOKEN_KEY);
    await ShareStorage.storage.remove(MyConfig.REFRESH_TOKEN_KEY);
  }

  Future<bool> logout() async {
    showLoadingDialog();

    try {
      appController.isLogin.value = false;
      await authRepositories.logout();

      removeAccessToken();

      appController.isLogin.value = false;
      homeController.rxListNearByProduct.clear();
      hideDialog();

      Get.back(result: false);
      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }

  Future<void> deleteUser() async {
    showLoadingDialog();

    try {
      await userRepositories.deleteUser();
      removeAccessToken();
      hideDialog();
      Get.back();
      Get.back(result: false);
      handleSuccessStringShowToast(message: 'Xoá tài khoản thành công');
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }
}
