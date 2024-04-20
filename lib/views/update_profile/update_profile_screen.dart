import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/update_profile/update_profile_binding.dart';
import 'package:ints/views/update_profile/widgets/avatar_widget.dart';

class UpdateProfileScreen extends BaseView<UpdateProfileController> {
  @override
  Widget vBuilder() {
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: MyColor.BACKGROUND_COLOR,
        body: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                color: MyColor.white,
                child: Obx(() => AvatarWidget(
                      file: controller.rxFile.value,
                      onTap: () {
                        controller.onPickImage();
                      },
                      user: controller.appController.rxUser.value,
                      isEdit: controller.rxIsUpdated.value,
                    )),
              ),
            ),
            IntrinsicHeight(
              child: GestureDetector(
                onTap: () async {
                  if (controller.rxIsUpdated.value) {
                    var data = await Get.toNamed(RouterName.update_full_name);
                    if (data != null) {
                      controller.rxFullName.value = data;
                    }
                  } else
                    null;
                },
                child: Obx(
                  () => Container(
                    decoration: (BoxDecoration(
                        color: MyColor.white,
                        border: Border(
                          bottom: BorderSide(width: 0.5, color: MyColor.border),
                          top: BorderSide(width: 0.5, color: MyColor.border),
                        ))),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tên",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColor.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              controller.rxFullName.value.length > 7
                                  ? controller.rxFullName.value.substring(0, 7) + '...'
                                  : controller.rxFullName.value,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.TEXT_COLOR_NEW),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: MyColor.TEXT_COLOR_NEW,
                              size: 24,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: (BoxDecoration(
                  color: MyColor.white,
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: MyColor.border),
                  ))),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Điện thoại",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.black,
                    ),
                  ),
                  Text(
                    controller.rxPhoneNumber.value.length > 7
                        ? '*******' +
                            controller.rxPhoneNumber.value
                                .substring(controller.rxPhoneNumber.value.length - 3)
                        : controller.rxPhoneNumber.value,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400, color: MyColor.TEXT_COLOR_NEW),
                  )
                ],
              ),
            ),
            Container(
              decoration: (BoxDecoration(
                  color: MyColor.white,
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: MyColor.border),
                  ))),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.black,
                    ),
                  ),
                  Text(
                    controller.rxEmail.value.indexOf('@') > 1
                        ? controller.rxEmail.value[0] +
                            '*' * (controller.rxEmail.value.indexOf('@') - 2) +
                            controller.rxEmail.value[controller.rxEmail.value.indexOf('@') - 1] +
                            controller.rxEmail.value
                                .substring(controller.rxEmail.value.indexOf('@'))
                        : controller.rxEmail.value,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400, color: MyColor.TEXT_COLOR_NEW),
                  )
                ],
              ),
            ),
          ],
        ));
  }

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
        Obx(() => InkWell(
              onTap: () {
                if (!controller.rxIsUpdated.value) {
                  controller.rxIsUpdated.value = true;
                } else {
                  controller.updateProfile();
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 25),
                decoration: BoxDecoration(
                    color: MyColor.PRIMARY_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  !controller.rxIsUpdated.value ? "Sửa" : 'Lưu',
                  style: TextStyle(color: MyColor.white, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            )),
      ],
    );
  }
}
