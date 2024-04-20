import 'package:flutter/cupertino.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/home/home_binding.dart';

import '../../x_utils/get_storage_util.dart';
import '../app/app_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}

class LoginController extends BaseController {
  RxBool isChecked =
      RxBool(ShareStorage.storage.read(MyConfig.PASSWORD) != null);

  final userNameTextController = TextEditingController(
      text: ShareStorage.storage.read(MyConfig.USER_NAME) ?? "");
  final passwordTextController = TextEditingController(
      text: ShareStorage.storage.read(MyConfig.PASSWORD) ?? "");
  AppController appController = Get.find();
  final homeController = Get.find<HomeController>();

  Future<bool> login() async {
    showLoadingDialog();

    try {
      String userInput = userNameTextController.text.trim();

      var res = await authRepositories.login(
        user: userInput,
        password: passwordTextController.text,
      );
      appController.rxUser.value = res.user;

      saveAccessToken(
        accessToken: res.token,
        refreshToken: res.refreshToken,
      );

      appController.isLogin.value = true;
      homeController.fetchNearbyProducts();
      homeController.onRefresh();
      hideDialog();
      while (Get.currentRoute != RouterName.home) {
        Get.back();
      }

      if (isChecked.value) {
        savePassword(userNameTextController.text, passwordTextController.text);
      } else {
        removePassword();
      }

      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }

  Future<bool> loginPhone() async {
    showLoadingDialog();
    try {
      String userInput = userNameTextController.text.trim();

      var res = await authRepositories.loginPhone(
        phone: userInput,
        password: passwordTextController.text,
      );
      appController.rxUser.value = res.user;

      saveAccessToken(
        accessToken: res.token,
        refreshToken: res.refreshToken,
      );

      appController.isLogin.value = true;
      hideDialog();
      while (Get.currentRoute != RouterName.home) {
        Get.back();
      }

      if (isChecked.value) {
        savePassword(userNameTextController.text, passwordTextController.text);
      } else {
        removePassword();
      }

      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }

  Future<void> saveAccessToken(
      {String? accessToken, String? refreshToken}) async {
    await ShareStorage.storage
        .write(MyConfig.ACCESS_TOKEN_KEY, accessToken ?? "");
    await ShareStorage.storage
        .write(MyConfig.REFRESH_TOKEN_KEY, refreshToken ?? "");
  }

  Future<void> savePassword(String userName, String password) async {
    await ShareStorage.storage.write(MyConfig.USER_NAME, userName);
    await ShareStorage.storage.write(MyConfig.PASSWORD, password);
  }

  Future<void> removePassword() async {
    await ShareStorage.storage.remove(MyConfig.USER_NAME);
    await ShareStorage.storage.remove(MyConfig.PASSWORD);
    isChecked.value = false;
  }

  bool isEmail(String input) {
    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegExp.hasMatch(input);
  }

  bool isPhoneNumber(String input) {
    final phoneRegExp = RegExp(
      r'^[0-9]{10}$',
      caseSensitive: false,
      multiLine: false,
    );
    return phoneRegExp.hasMatch(input);
  }
}
