import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../x_res/my_config.dart';
import '../../../x_utils/widgets/my_text_form_field.dart';

class PasswordDialog extends StatelessWidget {
  final Function onConfirm;
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController reNewPasswordController;

  PasswordDialog(
      {super.key,
      required this.onConfirm,
      required this.oldPasswordController,
      required this.newPasswordController,
      required this.reNewPasswordController});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Đổi mật khẩu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              _label('Mật khẩu cũ '),
              const SizedBox(height: 5),
              MyTextFormField(
                labelText: 'Mật khẩu cũ',
                obscureText: true,
                controller: oldPasswordController,
              ),
              const SizedBox(height: 10),
              _label('Mật khẩu mới '),
              const SizedBox(height: 5),
              MyTextFormField(
                labelText: 'Mật khẩu mới',
                obscureText: true,
                controller: newPasswordController,
              ),
              const SizedBox(height: 10),
              _label('Nhập lại mật khẩu mới '),
              const SizedBox(height: 5),
              MyTextFormField(
                labelText: 'Nhập lại mật khẩu mới',
                obscureText: true,
                controller: reNewPasswordController,
              ),
              const SizedBox(height: 30),
              _note(),
              const SizedBox(height: 20),
              _buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Row(
      children: [
        Text(text),
        Text("(*)",
            style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic)),
      ],
    );
  }

  Widget _note() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Lưu ý: ",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
          const SizedBox(height: 5),
          Text(
            "1. Mật khẩu mới phải có độ dài "
            "tối thiểu 8 ký tự",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
          Text(
            "2. Mật khẩu mới phải bao gồm "
            "cả chữ hoa, chữ thường, số"
            " và ký tự đặc biệt",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
          Text(
            "3. Mật khẩu không chứa tên "
            "đăng nhập hoặc email",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
          Text(
            "4. Mật khẩu mới không được đặt"
            " là Demo@123, 123456aA@, "
            "12345678aA@",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text('Hủy bỏ'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.PRIMARY_COLOR,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text('Cập nhật'),
        ),
      ],
    );
  }
}
