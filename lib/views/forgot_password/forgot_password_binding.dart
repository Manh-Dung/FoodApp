import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/app/app_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}

class ForgotPasswordController extends BaseController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordNewController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  AppController appController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> forgotPassword() async {
    showLoadingDialog();
    try {
      await authRepositories.forgotPassword(
        email: emailController.text,
      );

      hideDialog();
      Get.toNamed(RouterName.opt_screen);
      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }

  Future<bool> sendOTP() async {
    showLoadingDialog();
    try {
      await authRepositories.sendOTP(
        email: emailController.text,
        otp: otpController.text,
      );
      hideDialog();
      Get.toNamed(RouterName.create_new_password);

      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }

  Future<bool> resetPassword() async {
    showLoadingDialog();
    try {
      await authRepositories.resetPassword(
          email: emailController.text,
          otp: otpController.text,
          password: passwordConfirmController.text);
      hideDialog();
      Get.offAndToNamed(RouterName.change_password_success);
      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }
}
