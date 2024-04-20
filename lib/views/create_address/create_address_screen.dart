import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/create_address/create_address_binding.dart';

import '../product_detail/widgets/address_text_field.dart';

class CreateAddressScreen extends BaseView<CreateAddressController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: MyColor.BACKGROUND_COLOR),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _contactWidget(),
              const SizedBox(height: 4),
              Obx(() => _addressWidget()),
              const SizedBox(height: 4),
              _settingWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _addressBottomBtn(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Địa chỉ nhận hàng',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: MyColor.TEXT_COLOR_NEW,
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
        child: Obx(() => GestureDetector(
              onTap: () {
                controller.rxIsEnableBtn.value
                    ? controller.rxSelectedAddress.value == null
                        ? controller.addAddress()
                        : controller.updateAddress()
                    : null;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: controller.rxIsEnableBtn.value
                        ? MyColor.PRIMARY_COLOR
                        : MyColor.INPUT_FORM_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  'Hoàn thành',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: controller.rxIsEnableBtn.value
                          ? MyColor.white
                          : MyColor.BORDER_COLOR),
                ),
              ),
            )));
  }

  Widget _contactWidget() {
    return Container(
        color: MyColor.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Liên hệ",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(23, 23, 23, 1)),
          ),
          const SizedBox(height: 6),
          AddressTextField(
            controller: controller.fullNameTextController,
            hintText: "Họ và tên",
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              controller.rxIsEnableBtn.value = controller.isEnableBtn;
            },
          ),
          const SizedBox(height: 8),
          AddressTextField(
            controller: controller.phoneNumberTextController,
            hintText: "Số điện thoại",
            onChanged: (value) {
              controller.rxIsEnableBtn.value = controller.isEnableBtn;
            },
          ),
        ]));
  }

  Widget _addressWidget() {
    return Container(
        color: MyColor.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Địa chỉ",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(23, 23, 23, 1)),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () async {
              var data = await Get.toNamed(RouterName.select_address);
              controller.rxSelectedLocation.value = data;
              var selectedLocationParts =
                  controller.splitString(controller.rxSelectedLocation.value);

              if (selectedLocationParts.length == 3) {
                controller.rxSelectedCity.value = controller
                    .splitString(controller.rxSelectedLocation.value)[2];
                controller.rxSelectedDistrict.value = controller
                    .splitString(controller.rxSelectedLocation.value)[1];
                controller.rxSelectedWard.value = controller
                    .splitString(controller.rxSelectedLocation.value)[0];
              } else if (selectedLocationParts.length < 3) {
                controller.rxSelectedCity.value = controller
                    .splitString(controller.rxSelectedLocation.value)[1];
                controller.rxSelectedDistrict.value = controller
                    .splitString(controller.rxSelectedLocation.value)[0];
                controller.rxSelectedWard.value = '0';
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      controller.rxSelectedLocation.value != ""
                          ? controller.rxSelectedLocation.value
                          : "Tỉnh/Thành phố, Quận/Huyện, Phường/Xã",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(50, 57, 65, 1)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SvgPicture.asset(XR().svgImage.ic_arrow_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          AddressTextField(
            controller: controller.addressDetailTextController,
            hintText: "Tên đường, Toà nhà, Số nhà",
            onChanged: (value) {
              controller.rxIsEnableBtn.value = controller.isEnableBtn;
            },
          ),
        ]));
  }

  Widget _settingWidget() {
    return Container(
      color: MyColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Cài đặt",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(23, 23, 23, 1)),
        ),
        const SizedBox(height: 8),
        Divider(height: 1, color: MyColor.DIVIDER_COLOR),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            width: 0.5,
            color: Color.fromRGBO(217, 217, 217, 1),
          ))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Loại địa chỉ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: MyColor.TEXT_COLOR_NEW),
                ),
                Obx(() => Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.rxTypeLocation.value = 1;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.rxTypeLocation.value == 1
                                    ? MyColor.white
                                    : MyColor.CHECKBOX_COLOR,
                                border: Border.all(
                                    color: controller.rxTypeLocation.value == 1
                                        ? MyColor.PRIMARY_COLOR
                                        : MyColor.CHECKBOX_COLOR,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: Text(
                                'Văn phòng',
                                style: TextStyle(
                                    color: controller.rxTypeLocation.value == 1
                                        ? MyColor.PRIMARY_COLOR
                                        : MyColor.BORDER_COLOR,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            controller.rxTypeLocation.value = 0;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.rxTypeLocation.value == 0
                                    ? MyColor.white
                                    : MyColor.CHECKBOX_COLOR,
                                border: Border.all(
                                    color: controller.rxTypeLocation.value == 0
                                        ? MyColor.PRIMARY_COLOR
                                        : MyColor.CHECKBOX_COLOR,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: Text(
                                'Nhà riêng',
                                style: TextStyle(
                                    color: controller.rxTypeLocation.value == 0
                                        ? MyColor.PRIMARY_COLOR
                                        : MyColor.BORDER_COLOR,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        Divider(height: 1, color: MyColor.DIVIDER_COLOR),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Đặt làm địa chỉ mặc định',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.TEXT_COLOR_NEW),
            ),
            Obx(() => Switch(
                  value: controller.rxSwitchValue.value,
                  onChanged: (value) {
                    controller.rxSwitchValue.value = value;
                    controller.rxIsEnableBtn.value = true;
                  },
                  inactiveTrackColor: Color.fromRGBO(120, 120, 128, 0.16),
                  inactiveThumbColor: MyColor.white,
                  trackOutlineColor: MaterialStateProperty.resolveWith(
                    (final Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return null;
                      }
                      return Colors.white;
                    },
                  ),
                ))
          ],
        ),
      ]),
    );
  }
}
