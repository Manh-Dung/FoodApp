import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/address_selection/address_selection_binding.dart';
import 'package:ints/views/pickup_address/widgets/progress_widget.dart';

class AddressSelectionScreen extends BaseView<AddressSelectionController> {
  @override
  Widget vBuilder() => Scaffold(
        backgroundColor: MyColor.BACKGROUND_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              _headerBar(),
              SizedBox(height: 3),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    color: MyColor.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      child: Obx(() => Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    controller.setCurrentAddress();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(XR().svgImage.ic_location,
                                          width: 24, height: 24),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Sử dụng vị trí hiện tại",
                                        style: TextStyle(
                                            color: MyColor.PRIMARY_COLOR,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      minimumSize: Size(0, 0),
                                      backgroundColor: MyColor.white,
                                      side: BorderSide(color: MyColor.PRIMARY_COLOR),
                                      padding: const EdgeInsets.symmetric(vertical: 17),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8))),
                                ),
                              ),
                              Column(
                                children: [
                                  ProgressWidget(
                                    isFirst: true,
                                    isLast: false,
                                    isPast: controller.isCityPast.value,
                                    locationLevel: controller.cityLevelString.value,
                                    selectLocationLevel: () {
                                      controller.updateCurrentLocationList(
                                          controller.cityLevelString.value);
                                    },
                                    resetSelection: controller.resetSelection,
                                  ),
                                  ProgressWidget(
                                    isFirst: false,
                                    isLast: false,
                                    isPast: controller.isDistrictPast.value,
                                    locationLevel: controller.districtLevelString.value,
                                    selectLocationLevel: () {
                                      controller.updateCurrentLocationList(
                                        controller.districtLevelString.value,
                                      );
                                    },
                                  ),
                                  ProgressWidget(
                                    isFirst: false,
                                    isLast: true,
                                    isPast: controller.isWardPast.value,
                                    locationLevel: controller.wardLevelString.value,
                                    selectLocationLevel: () {
                                      controller.updateCurrentLocationList(
                                        controller.wardLevelString.value,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: (() {
                            if (controller.selectedLocationLevel ==
                                controller.cityLevelString.value) {
                              return Text(
                                "Tỉnh / Thành phố",
                                style: TextStyle(
                                  color: Color.fromRGBO(148, 148, 153, 1),
                                ),
                              );
                            } else if (controller.selectedLocationLevel ==
                                controller.districtLevelString.value) {
                              return Text(
                                "Quận / Huyện",
                                style: TextStyle(
                                  color: Color.fromRGBO(148, 148, 153, 1),
                                ),
                              );
                            } else if (controller.selectedLocationLevel ==
                                controller.wardLevelString.value) {
                              return Text(
                                "Phường / Xã",
                                style: TextStyle(
                                  color: Color.fromRGBO(148, 148, 153, 1),
                                ),
                              );
                            }
                          })()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: MyColor.white,
                      child: Obx(() => ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (controller.selectedLocationLevel ==
                                    controller.cityLevelString.value) {
                                  controller.updateDistrictList(
                                      controller.currentLocationList[index].code);
                                  controller.isCityPast.value = true;
                                  controller.cityLevelString.value =
                                      "Tỉnh / Thành phố: ${controller.currentLocationList[index].name}";
                                  // controller.createAddressController.rxSelectedCity.value =
                                  //     controller.currentLocationList[index].name;
                                } else if (controller.selectedLocationLevel ==
                                    controller.districtLevelString.value) {
                                  controller
                                      .updateWardList(controller.currentLocationList[index].code);
                                  controller.isDistrictPast.value = true;
                                  controller.districtLevelString.value =
                                      "Quận / Huyện: ${controller.currentLocationList[index].name}";
                                  // controller.createAddressController.rxSelectedDistrict
                                  //     .value = controller.currentLocationList[index].name;
                                } else if (controller.selectedLocationLevel ==
                                    controller.wardLevelString.value) {
                                  controller.isWardPast.value = true;
                                  controller.wardLevelString.value =
                                      "Phường / Xã: ${controller.currentLocationList[index].name}";
                                  // controller.createAddressController.rxSelectedWard.value =
                                  //     controller.currentLocationList[index].name;
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: SizedBox(
                                  height: 35,
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity(vertical: 0.2),
                                    title: Align(
                                      alignment: FractionalOffset.topLeft,
                                      child: Text(
                                        controller.currentLocationList.length != 0
                                            ? controller.currentLocationList[index].name
                                            : "",
                                        style: TextStyle(
                                            color: Color.fromRGBO(78, 79, 84, 1), fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Divider(height: 1, color: Color.fromRGBO(217, 217, 217, 1)),
                          itemCount: controller.currentLocationList.length)),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      );

  PhysicalModel _headerBar() {
    return PhysicalModel(
      elevation: 8,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.25).withOpacity(0.3),
      color: Colors.white,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: SvgPicture.asset(
                      XR().svgImage.ic_back,
                    ),
                    onPressed: () {
                      controller.getBack();
                    }),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 16),
                    child: TextField(
                      controller: controller.locationLevelTextController,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(
                            maxHeight: 40,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          filled: true,
                          prefixIcon: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              XR().svgImage.ic_search,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          fillColor: MyColor.BACKGROUND_COLOR,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                          hintText: "Tìm kiếm",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(148, 148, 153, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),
                      onChanged: (value) {
                        if (controller.selectedLocationLevel == controller.cityLevelString.value) {
                          controller.updateFilteredCityList(value);
                        } else if (controller.selectedLocationLevel ==
                            controller.districtLevelString.value) {
                          controller.updateFilteredDistrictList(value);
                        } else if (controller.selectedLocationLevel ==
                            controller.wardLevelString.value) {
                          controller.updateFilteredWardList(value);
                        }
                      },
                    ),
                  ),
                  flex: 7),
              Expanded(
                flex: 1,
                child: Container(
                  child: IconButton(
                    icon: SvgPicture.asset(XR().svgImage.ic_maprepo),
                    onPressed: () {
                      Get.toNamed(RouterName.map);
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
