import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/forgot_password/forgot_password_binding.dart';

import '../../../x_utils/widgets/my_text_form_field.dart';

class CreateNewPassword extends BaseView<ForgotPasswordController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tạo mật khẩu mới",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: MyColor.TEXT_COLOR_NEW,
                  fontSize: 24),
            ),
            Text(
              "Mật khẩu mới phải khác so với mật khẩu đã sử dụng trước đó.",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.TEXT_COLOR_NEW),
            ),
            const SizedBox(height: 36),
            MyTextFormField(
              obscureText: true,
              controller: controller.passwordNewController,
              labelText: "Mật khẩu mới",
            ),
            const SizedBox(height: 8),
            MyTextFormField(
              obscureText: true,
              controller: controller.passwordConfirmController,
              labelText: "Xác nhận mật khẩu mới",
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                if (controller.passwordNewController.text !=
                    controller.passwordConfirmController.text) {
                  controller.handleErrorStringShowToast(
                      error: "Mật khẩu không trùng khớp");
                } else {
                  controller.resetPassword();
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                decoration: BoxDecoration(
                    color: MyColor.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Tạo mật khẩu mới",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn chưa nhận được mã OTP? ",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouterName.register);
                      },
                      child: Text(
                        "Gửi lại",
                        style: TextStyle(color: MyColor.PRIMARY_COLOR),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
