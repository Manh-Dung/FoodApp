import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/register/register_binding.dart';
import 'package:ints/x_utils/widgets/my_text_form_field.dart';
import 'package:ints/x_utils/widgets/rich_text_button.dart';

import '../../x_utils/widgets/authentication_button.dart';

class RegisterScreen extends BaseView<RegisterController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget vBuilder() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 88),

              const SizedBox(height: 24),
              Text(
                "Xin chào bạn! \nHãy đăng ký để bắt đầu",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: MyColor.TEXT_COLOR_NEW,
                ),
              ),
              SizedBox(height: 24),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        controller: controller.fullNameTextController,
                        labelText: XR().string.name,
                        isName: true,
                      ),
                      const SizedBox(height: 8),
                      MyTextFormField(
                        controller: controller.emailTextController,
                        labelText: XR().string.email_log_in,
                        isEmail: true,
                      ),
                      const SizedBox(height: 8),
                      MyTextFormField(
                        controller: controller.phoneTextController,
                        labelText: "Số điện thoại",
                      ),
                      const SizedBox(height: 8),
                      MyTextFormField(
                        controller: controller.passwordTextController,
                        labelText: XR().string.password,
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      MyTextFormField(
                        controller: controller.confirmPasswordTextController,
                        labelText: XR().string.confirm_password,
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),

                                  value: controller.isCheck.value,
                                  onChanged: (bool? value) {
                                    controller.isCheck.value = value!;
                                  },
                                  activeColor: MyColor.white,
                                  checkColor: MyColor.PRIMARY_COLOR,
                                  splashRadius: 20,
                              side: MaterialStateBorderSide.resolveWith(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return BorderSide(color: MyColor.CHECKBOX_COLOR, width: 1.0);
                                  }
                                  return BorderSide(color: Colors.grey, width: 1.0);
                                },
                              ),
                                  // side: BorderSide(
                                  //   color: Colors.grey,
                                  //   width: 1,
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  focusColor: Colors.grey,
                                  hoverColor: Colors.grey,
                                )),
                            const SizedBox(width: 3),
                            RichTextButton(
                                unTapableMessage:
                                    XR().string.i_have_read_and_agree_with,
                                tapableMessage: XR().string.terms_of_use,
                                onPressed: () {})
                          ]),
                      const SizedBox(height: 16),
                      AuthenticationButton(
                        message: XR().string.register,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (controller.isCheck.value) {
                              controller.fullNameTextController.text =
                                  controller.fullNameTextController.text
                                      .trimRight();
                              controller.emailTextController.text = controller
                                  .emailTextController.text
                                  .trimRight();

                              controller.signUp();
                            } else {
                              controller.handleErrorStringShowToast(
                                  error: XR().string.please_check);
                            }
                          }
                        },
                      ),
                    ],
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        XR().string.do_you_have_an_account,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RouterName.login);
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                              color: Colors.green.shade800, fontSize: 12),
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
      ),
    );
  }
}
