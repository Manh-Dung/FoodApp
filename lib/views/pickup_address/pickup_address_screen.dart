import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';

import 'pickup_address_binding.dart';
import 'widgets/address_widget.dart';

class PickUpAddressScreen extends BaseView<PickUpAddressController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: MyColor.BACKGROUND_COLOR,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onRefresh();
        },
        child: Obx(
          () => Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
                      child: Text(
                        "Địa chỉ đã lưu",
                        style: TextStyle(
                          color: Color.fromRGBO(148, 148, 153, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    controller: controller.scrollController,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemCount: controller.rxListAddress.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouterName.create_address, arguments: {
                            "selectedAddress": controller.rxListAddress[index],
                          });
                        },
                        child: IntrinsicHeight(
                          child: Obx(
                            () => AddressWidget(
                              editAddress: () =>
                                  controller.updateEditStatus(index),
                              removeAddress: () => controller.removeAddress(
                                  controller.rxListAddress[index].id ?? 0),
                              isBeingEdited: controller.isBeingEdited[index],
                              address: controller.rxListAddress[index],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
        child: InkWell(
          onTap: () async {
            await Get.toNamed(RouterName.create_address);
            controller.isBeingEdited.assignAll(List.generate(
                controller.rxListAddress.length, (index) => false));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: MyColor.PRIMARY_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              'Thêm địa chỉ mới',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: MyColor.white,
              ),
            ),
          ),
        ),
      ),
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
            color: Color.fromRGBO(78, 79, 84, 1),
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
}
