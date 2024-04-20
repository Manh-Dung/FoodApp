import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/account_setting/widgets/setting_title_item_widget.dart';

import 'account_setting_binding.dart';
import 'widgets/setting_item_widget.dart';

class AccountSettingScreen extends BaseView<AccountSettingController> {
  @override
  Widget vBuilder() => Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: _addressBottomBtn(),
        backgroundColor: MyColor.BACKGROUND_COLOR,
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SettingTitleItemWidget(title: "Tài khoản của tôi"),
                  SettingItemWidget(
                      text: "Tài khoản & bảo mật",
                      onTap: () {
                        Get.toNamed(RouterName.update_profile);
                      }),
                  Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                  SettingItemWidget(
                      text: 'Địa chỉ',
                      onTap: () {
                        Get.toNamed(RouterName.pickup_address);
                      }),
                  SettingTitleItemWidget(title: "Cài đặt"),
                  SettingItemWidget(text: "Cài đặt thông báo", onTap: () {}),
                  Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                  SettingItemWidget(
                      text: 'Ngôn ngữ: Tiếng Việt',
                      onTap: () {
                        Get.toNamed(RouterName.language);
                      }),
                  SettingTitleItemWidget(title: "Hỗ trợ"),
                  SettingItemWidget(text: "Tiêu chuẩn cộng đồng", onTap: () {}),
                  Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                  SettingItemWidget(text: 'Điều khoản T&T Food', onTap: () {}),
                  Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                  SettingItemWidget(
                      text: "Hài lòng với T&T Food? Hãy đánh giá ngay nhé!",
                      onTap: () {}),
                  Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                  SettingItemWidget(
                      text: 'Giới thiệu',
                      onTap: () {
                        Get.toNamed(RouterName.about_us,
                            arguments: {"title": "Giới thiệu"});
                      }),
                  Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                  SettingItemWidget(
                      text: 'Yêu cầu hủy tài khoản',
                      onTap: () {
                        showGeneralDialog(
                            context: Get.context!,
                            barrierDismissible: true,
                            barrierLabel: "Label",
                            transitionDuration: Duration(milliseconds: 200),
                            pageBuilder: (_, a1, a2) {
                              return Dialog(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Lưu ý tài khoản đã xóa sẽ không được mở lại. Bạn có chắc chắn muốn xóa ?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.TEXT_COLOR_NEW,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                      color: MyColor
                                                          .TEXT_COLOR_NEW,
                                                      width: 1,
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    minimumSize: Size(0, 40),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  child: Text("Huỷ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: MyColor
                                                              .TEXT_COLOR_NEW))),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: OutlinedButton(
                                                  onPressed: () {
                                                    controller.deleteUser();
                                                   
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                      color:
                                                          MyColor.PRIMARY_COLOR,
                                                      width: 1,
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    minimumSize: Size(0, 40),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  child: Text("Đồng ý",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: MyColor
                                                              .PRIMARY_COLOR))),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
            ),
          ),
        ),
      );

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Thiết lập tài khoản',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      centerTitle: true,
    );
  }

  Widget _addressBottomBtn() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, -1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: GestureDetector(
          onTap: () {
            controller.logout();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: MyColor.PRIMARY_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              'Đăng xuất',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: MyColor.white),
            ),
          ),
        ));
  }
}
