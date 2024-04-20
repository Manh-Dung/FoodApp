import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/forgot_password/forgot_password_binding.dart';
import 'package:ints/x_utils/widgets/authentication_button.dart';
import 'package:ints/x_utils/widgets/my_text_form_field.dart';

class ForgotPasswordScreen extends BaseView<ForgotPasswordController> {
  final _formKey = GlobalKey<FormState>();

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quên mật khẩu?",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: MyColor.TEXT_COLOR_NEW),
            ),
            Text(
              "Vui lòng nhập địa chỉ email được liên kết với tài khoản của bạn ",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.TEXT_COLOR_NEW),
            ),
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                      labelText: XR().string.user_name_or_email,
                      isEmail: true,
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 12),
                    AuthenticationButton(
                        message: "Gửi mã xác nhận",
                        onPressed: () async {
                          controller.emailController.text =
                              controller.emailController.text.trimRight();
                          if (_formKey.currentState!.validate()) {
                            await controller.forgotPassword();
                          }
                        }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
