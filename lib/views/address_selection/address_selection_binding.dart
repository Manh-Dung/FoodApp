import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/address/address_city.dart';
import 'package:ints/models/address/address_district.dart';
import 'package:http/http.dart' as http;
import 'package:ints/views/create_address/create_address_binding.dart';

class AddressSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddressSelectionController());
  }
}

class AddressSelectionController extends BaseController {
  // filter list
  RxList<AddressCity> rxListAddressCity = RxList();
  RxList<AddressDistrict> rxListAddressDistrict = RxList();
  RxList<AddressDistrict> rxListAddressWards = RxList();

  // search
  final locationLevelTextController = TextEditingController();

  // origin list
  List<AddressCity> originalCityList = [];
  List<AddressDistrict> originalDistrictList = [];
  List<AddressDistrict> originalWardList = [];

  // current list
  RxList<dynamic> currentLocationList = RxList();

  String selectedLocationLevel = '';

  Rx<String> cityLevelString = RxString('Chọn Tỉnh / Thành phố');
  Rx<String> districtLevelString = RxString('Chọn Quận / Huyện');
  Rx<String> wardLevelString = RxString('Chọn Phường / Xã');

  Rx<bool> isCityPast = Rx<bool>(false);
  Rx<bool> isDistrictPast = Rx<bool>(false);
  Rx<bool> isWardPast = Rx<bool>(false);

  RxString rxSelectedLocation = RxString("");
  final createAddressController = Get.find<CreateAddressController>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      cityLevelString.value = Get.arguments['selectedCity'];
      districtLevelString.value = Get.arguments['selectedDistrict'];
      wardLevelString.value = Get.arguments['selectedWard'];

      if (cityLevelString.value != "Chọn Tỉnh / Thành phố") {
        isCityPast.value = true;
        isDistrictPast.value = true;
        isWardPast.value = true;
      } else {
        isCityPast.value = false;
        isDistrictPast.value = false;
        isWardPast.value = false;
      }
    } else {
      print('Error: Null address');
    }
    super.onInit();
    getAddressCity();
  }

  Future<List<AddressCity>> getAddressCity() async {
    try {
      var res = await addressRepositories.getAddress();
      rxListAddressCity.value = res;
      originalCityList = List.from(res);
      rxListAddressCity.refresh();
      update();
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<AddressDistrict>> getAddressDistrict(String cityCode) async {
    try {
      var res = await addressRepositories.getAddressDistrict(cityCode);
      rxListAddressDistrict.value = res;
      originalDistrictList = List.from(res);
      rxListAddressDistrict.refresh();

      update();
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateDistrictList(String cityCode) async {
    try {
      List<AddressDistrict> res = await getAddressDistrict(cityCode);
      rxListAddressDistrict.value = res;
      originalDistrictList = List.from(res);
      rxListAddressDistrict.refresh();
      update();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateWardList(String districtCode) async {
    try {
      List<AddressDistrict> res = await getAddressWard(districtCode);
      rxListAddressDistrict.value = res;
      originalDistrictList = List.from(res);
      rxListAddressDistrict.refresh();
      update();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<AddressDistrict>> getAddressWard(String districtCode) async {
    try {
      var res = await addressRepositories.getAddressWards(districtCode);
      rxListAddressWards.value = res;
      originalWardList = List.from(res);
      rxListAddressWards.refresh();

      update();
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  void updateFilteredCityList(String value) {
    List<AddressCity> filteredList = originalCityList
        .where((city) =>
            (city.name ?? "").toLowerCase().contains(value.toLowerCase()))
        .toList();

    rxListAddressCity.value = filteredList;
    rxListAddressCity.refresh();
    update();
  }

  void updateFilteredDistrictList(String value) {
    List<AddressDistrict> filteredList = originalDistrictList
        .where((district) =>
            district.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    rxListAddressDistrict.value = filteredList;
    rxListAddressDistrict.refresh();
    update();
  }

  void updateFilteredWardList(String value) {
    List<AddressDistrict> filteredList = originalWardList
        .where((ward) => ward.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    rxListAddressWards.value = filteredList;
    rxListAddressWards.refresh();
    update();
  }

  void updateCurrentLocationList(String locationLevel) {
    switch (locationLevel) {
      case "Chọn Tỉnh / Thành phố":
        currentLocationList.value = rxListAddressCity;
        originalCityList = List.from(rxListAddressCity);
        selectedLocationLevel = "Chọn Tỉnh / Thành phố";
        update();

        break;
      case "Chọn Quận / Huyện":
        currentLocationList.value = rxListAddressDistrict;
        originalDistrictList = List.from(rxListAddressDistrict);
        selectedLocationLevel = "Chọn Quận / Huyện";
        if (originalDistrictList.isEmpty) {
          handleErrorStringShowToast(error: "Bạn chưa chọn tỉnh / thành phố");
        }
        update();

        break;
      case "Chọn Phường / Xã":
        currentLocationList.value = rxListAddressWards;
        originalWardList = List.from(rxListAddressWards);
        selectedLocationLevel = "Chọn Phường / Xã";
        if (originalWardList.isEmpty) {
          handleErrorStringShowToast(error: "Bạn chưa chọn quận / huyện");
        }
        update();

        break;
      default:
        break;
    }
  }

  void resetSelection() {
    selectedLocationLevel = "";
    cityLevelString.value = "Chọn Tỉnh / Thành phố";
    districtLevelString.value = "Chọn Quận / Huyện";
    wardLevelString.value = "Chọn Phường / Xã";
    currentLocationList.value = rxListAddressCity;
    originalCityList = List.from(rxListAddressCity);
    originalDistrictList = List.from(rxListAddressDistrict);
    originalWardList = List.from(rxListAddressWards);
    isCityPast.value = false;
    isDistrictPast.value = false;
    isWardPast.value = false;
    update();
  }

  String getValueAfterColon(String text) {
    final parts = text.split(':');
    if (parts.length > 1) {
      return parts[1].trim();
    } else {
      return text;
    }
  }

  void getBack() {
    if (showAlertDialog() == true) {
      rxSelectedLocation.value = getValueAfterColon(wardLevelString.value) +
          ", " +
          getValueAfterColon(districtLevelString.value) +
          ", " +
          getValueAfterColon(cityLevelString.value);
      getCoordinatesFromAddress(rxSelectedLocation.value).then((value) {
        createAddressController.rxSelectedLatitude.value = value.latitude;
        createAddressController.rxSelectedLongitude.value = value.longitude;
      });
      hideDialog();
      Get.back(result: rxSelectedLocation.value);
    }
  }

  bool showAlertDialog() {
    if (getValueAfterColon(cityLevelString.value) == "Chọn Tỉnh / Thành phố" ||
        getValueAfterColon(districtLevelString.value) == "Chọn Quận / Huyện" ||
        getValueAfterColon(wardLevelString.value) == "Chọn Phường / Xã") {
      showGeneralDialog(
          context: Get.context!,
          barrierDismissible: true,
          barrierLabel: "Label",
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (_, a1, a2) {
            return _dialog();
          });
      return false;
    }
    return true;
  }

  Future<String> getCurrentAddress() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final String osmApiUrl =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}';

    final response = await http.get(Uri.parse(osmApiUrl));
    return jsonDecode(response.body)['display_name'];
  }

  Future<Location> getCoordinatesFromAddress(String text) async {
    List<Location> locations = await locationFromAddress(text);
    return locations.first;
  }

  Future setCurrentAddress() async {
    showLoadingDialog();
    try {
      getCurrentAddress().then((value) {
        List<String> addressNameParts = value.split(', ');
        if (addressNameParts.length > 5) {
          addressNameParts.removeRange(
              addressNameParts.length - 2, addressNameParts.length);
          List<String> currentAddressParts =
              addressNameParts.sublist(addressNameParts.length - 3);
          List<String> detailAddressParts =
              addressNameParts.sublist(0, addressNameParts.length - 3);
          String currentAddress = currentAddressParts.join(', ');
          String detailAddress = detailAddressParts.join(', ');
          getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
            createAddressController.rxSelectedLatitude.value = value.latitude;
            createAddressController.rxSelectedLongitude.value = value.longitude;
          });
          rxSelectedLocation.value = currentAddress;
          createAddressController.addressDetailTextController.text =
              detailAddress;
          createAddressController.rxIsEnableBtn.value = true;
          hideDialog();
          Get.back(result: rxSelectedLocation.value);
        } else if (addressNameParts.length == 5) {
          addressNameParts.removeRange(
              addressNameParts.length - 2, addressNameParts.length);
          String currentAddress = addressNameParts.join(', ');
          rxSelectedLocation.value = currentAddress;
          getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
            createAddressController.rxSelectedLatitude.value = value.latitude;
            createAddressController.rxSelectedLongitude.value = value.longitude;
          });
          hideDialog();
          Get.back(result: rxSelectedLocation.value);
        } else if (addressNameParts.length == 4) {
          if (int.tryParse(addressNameParts[addressNameParts.length - 2]) !=
              null) {
            addressNameParts.removeRange(
                addressNameParts.length - 2, addressNameParts.length);

            rxSelectedLocation.value = addressNameParts.join(', ');
            getCoordinatesFromAddress(addressNameParts.join(', '))
                .then((value) {
              createAddressController.rxSelectedLatitude.value = value.latitude;
              createAddressController.rxSelectedLongitude.value =
                  value.longitude;
            });
            hideDialog();
            Get.back(result: rxSelectedLocation.value);
          } else {
            addressNameParts.removeRange(
                addressNameParts.length - 1, addressNameParts.length);
            rxSelectedLocation.value = addressNameParts.join(', ');
            getCoordinatesFromAddress(addressNameParts.join(', '))
                .then((value) {
              createAddressController.rxSelectedLatitude.value = value.latitude;
              createAddressController.rxSelectedLongitude.value =
                  value.longitude;
            });
            hideDialog();
            Get.back(result: rxSelectedLocation.value);
          }
        } else if (addressNameParts.length == 3) {
          addressNameParts.removeRange(
              addressNameParts.length - 1, addressNameParts.length);
          rxSelectedLocation.value = addressNameParts.join(', ');
          getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
            createAddressController.rxSelectedLatitude.value = value.latitude;
            createAddressController.rxSelectedLongitude.value = value.longitude;
          });
          hideDialog();
          Get.back(result: rxSelectedLocation.value);
        }
      });
    } catch (e) {
      hideDialog();
      handleErr(e);
    }
  }

  Widget _dialog() {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Cập nhật chưa được lưu. Bạn có chắc chắn muốn\nhủy thay đổi?",
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
                          while (
                              Get.currentRoute != RouterName.create_address) {
                            Get.back();
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: MyColor.TEXT_COLOR_NEW,
                            width: 1,
                          ),
                          backgroundColor: Colors.white,
                          minimumSize: Size(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Thoát",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: MyColor.TEXT_COLOR_NEW))),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: MyColor.PRIMARY_COLOR,
                            width: 1,
                          ),
                          backgroundColor: Colors.white,
                          minimumSize: Size(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Hủy",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: MyColor.PRIMARY_COLOR))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
