// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ints/base/base_controller.dart';
// import 'package:ints/views/app/app_controller.dart';
//
// class ResetPasswordBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => ResetPasswordController());
//   }
// }
//
// class ResetPasswordController extends BaseController {
//   final otp = TextEditingController();
//   final newPassword = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   // RxBool isChecked = RxBool(false);
//   AppController appController = Get.find();
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<bool> resetPassword() async {
//     try {
//       await Future.delayed(Duration(seconds: 1));
//       await authRepositories.resetPassword(
//           hash: otp.text,
//           passwordNew: newPassword.text,
//           passWordConfirm: confirmPassword.text);
//
//       while (Get.currentRoute != RouterName.home) {
//         Get.back();
//       }
//       hideDialog();
//       return true;
//     } catch (e) {
//       handleErr(e);
//       return false;
//     }
//   }
// }
