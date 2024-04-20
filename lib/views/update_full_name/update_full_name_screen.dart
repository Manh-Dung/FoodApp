import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/update_full_name/update_full_name_binding.dart';

class UpdateFullNameScreen extends BaseView<UpdateFullNameController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget vBuilder() => Form(
        key: _formKey,
        child: Scaffold(
          appBar: _appBar(),
          backgroundColor: MyColor.BACKGROUND_COLOR,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.fullNameTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Họ và tên không được để trống';
                    } else if (value.length >= 100) {
                      return 'Họ và tên không được quá 100 ký tự';
                    }
                    return null;
                  },
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Giới hạn 100 ký tự',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: MyColor.TEXT_COLOR_NEW,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Sửa hồ sơ',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Get.back(result: controller.fullNameTextController.text);
            }
          },
          child: Container(
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 25),
            decoration: BoxDecoration(
                color: MyColor.PRIMARY_COLOR, borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              'Lưu',
              style: TextStyle(color: MyColor.white, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
