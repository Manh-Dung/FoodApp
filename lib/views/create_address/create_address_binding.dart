import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/nearby_product/nearby_product_binding.dart';

import '../../base/api_response_paging.dart';
import '../../models/address/address.dart';
import '../../models/cart/cart.dart';
import '../home/home_binding.dart';
import '../pickup_address/pickup_address_binding.dart';

class CreateAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAddressController());
    Get.lazyPut(() => PickUpAddressController());
    Get.lazyPut(() => NearByProductController());
    Get.lazyPut(() => HomeController());
  }
}

class CreateAddressController extends BaseController {
  Rxn<Address> rxDefaultAddress = Rxn();
  Rxn<Address> rxSelectedAddress = Rxn();

  RxList<CartItems> rxListCartItem = RxList();
  RxList<Cart> rxListCart = RxList();

  final fullNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final addressDetailTextController = TextEditingController();
  RxString rxSelectedCity = RxString("");
  RxString rxSelectedDistrict = RxString("");
  RxString rxSelectedWard = RxString("");
  RxBool rxSwitchValue = RxBool(false);
  RxInt rxTypeLocation = RxInt(0);

  RxBool rxIsEnableBtn = RxBool(false);

  RxString rxSelectedLocation = RxString("");
  RxNum rxSelectedLatitude = RxNum(0);
  RxNum rxSelectedLongitude = RxNum(0);
  final pickUpAddressController = Get.find<PickUpAddressController>();
  final nearByProductController = Get.find<NearByProductController>();
  final HomeController homeController = Get.find<HomeController>();
  @override
  void onInit() {
    super.onInit();
    if (pickUpAddressController.rxListAddress.length == 0) {
      rxSwitchValue.value = true;
    }
  }

  @override
  void onReady() {
    super.onReady();
    var listCart = Get.arguments["listCart"];
    var listCartItem = Get.arguments["listCartItem"];
    var selectedAddress = Get.arguments["selectedAddress"];

    if (listCart != null) {
      rxListCart.value = listCart;
    }
    if (listCartItem != null) {
      rxListCartItem.value = listCartItem;
    }

    if (selectedAddress != null &&
        pickUpAddressController.rxListAddress.length > 0) {
      rxSelectedAddress.value = selectedAddress;
      displaySelectedAddress(rxSelectedAddress.value);
      if (rxSelectedAddress.value?.isDefault == 1) rxSwitchValue.value = true;
    }

    rxIsEnableBtn.value = isEnableBtn;
  }

  Future addAddress() async {
    showLoadingDialog();
    try {
      var res = await addressRepositories.postAddress(
        fullNameTextController.text,
        phoneNumberTextController.text,
        rxSelectedCity.value,
        rxSelectedDistrict.value,
        rxSelectedWard.value,
        addressDetailTextController.text,
        rxSelectedLatitude.value,
        rxSelectedLongitude.value,
        rxTypeLocation.value,
      );

      if (rxSwitchValue.value) {
        await addressRepositories.setDefaultAddress(id: res.id ?? 0);
        getAllAddresses().then((value) => rxDefaultAddress.value =
            value.data?.firstWhere((element) => element.id == res.id));
      }

      handleSuccessStringShowToast(message: 'Thêm địa chỉ  thành công');

      if (pickUpAddressController.rxListAddress.length == 0 ||
          rxSwitchValue.value) {
        homeController.fetchNearbyProducts();
      }
      if (rxListCart.isNotEmpty) {
        Get.toNamed(RouterName.checkout, arguments: {
          "addressDefault": rxDefaultAddress.value,
          "listCart": rxListCart,
          "listCartItem": rxListCartItem
        });
      } else {
        var updatedAddresses = await pickUpAddressController.getAllAddresses();
        pickUpAddressController.rxListAddress
            .assignAll(updatedAddresses.data ?? []);
        while (Get.currentRoute != RouterName.pickup_address) {
          Get.back();
        }
      }
    } catch (e) {
      hideDialog();
      handleErr(e);
    }
  }

  Future<Location> getCoordinatesFromAddress(String text) async {
    List<Location> locations = await locationFromAddress(text);
    return locations.first;
  }

  Future updateAddress() async {
    showLoadingDialog();
    try {
      await getCoordinatesFromAddress(rxSelectedLocation.value).then((value) {
        rxSelectedLatitude.value = value.latitude;
        rxSelectedLongitude.value = value.longitude;
      });
      var res = await addressRepositories.editAddress(
        id: rxSelectedAddress.value?.id ?? 0,
        fullName: fullNameTextController.text,
        phoneNumber: phoneNumberTextController.text,
        province: rxSelectedCity.value,
        district: rxSelectedDistrict.value,
        ward: rxSelectedWard.value,
        detailAddress: addressDetailTextController.text,
        coordinateslat: rxSelectedLatitude.value,
        coordinateslong: rxSelectedLongitude.value,
        type: rxTypeLocation.value,
      );

      if (rxSwitchValue.value) {
        await addressRepositories.setDefaultAddress(id: res.id ?? 0);
        nearByProductController.defaultAddress =
            '${addressDetailTextController.text}, ${rxSelectedWard.value}, ${rxSelectedDistrict.value}, ${rxSelectedCity.value}';
        nearByProductController.update();

        homeController.fetchNearbyProducts();
      }

      hideDialog();
      handleSuccessStringShowToast(message: 'Cập nhật địa chỉ thành công');
      var updatedAddresses = await pickUpAddressController.getAllAddresses();
      pickUpAddressController.rxListAddress
          .assignAll(updatedAddresses.data ?? []);
      Get.back();
    } catch (e) {
      hideDialog();
      handleErr(e);
    }
  }

  Future<APIResponsePaging<List<Address>>> getAllAddresses() async {
    try {
      var res = await addressRepositories.getAllAddresses();
      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get address');
    }
  }

  void displaySelectedAddress(Address? address) {
    rxSelectedCity.value = address?.province ?? "Tỉnh";
    rxSelectedDistrict.value = address?.district ?? "Huyện";
    rxSelectedWard.value = address?.ward ?? "Xã";
    addressDetailTextController.text =
        address?.addressDetail ?? "Địa chỉ chi tiết";
    fullNameTextController.text = address?.fullName ?? "Họ và tên";
    phoneNumberTextController.text = address?.phoneNumber ?? "Số điện thoại";
    rxTypeLocation.value = address?.type?.toInt() ?? 0;
    rxSelectedLocation.value = rxSelectedCity.value +
        ", " +
        rxSelectedDistrict.value +
        ", " +
        rxSelectedWard.value;
  }

  bool get isEnableBtn {
    if (rxSelectedAddress.value != null) {
      if (rxSelectedCity.value != rxSelectedAddress.value?.province ||
          rxSelectedDistrict.value != rxSelectedAddress.value?.district ||
          rxSelectedWard.value != rxSelectedAddress.value?.ward ||
          addressDetailTextController.text !=
              rxSelectedAddress.value?.addressDetail ||
          fullNameTextController.text != rxSelectedAddress.value?.fullName ||
          phoneNumberTextController.text !=
              rxSelectedAddress.value?.phoneNumber ||
          rxTypeLocation.value != rxSelectedAddress.value?.type?.toInt()) {
        return true;
      } else {
        return false;
      }
    } else {
      if (rxSelectedCity.value != "" &&
          rxSelectedDistrict.value != "" &&
          addressDetailTextController.text != "Địa chỉ chi tiết" &&
          fullNameTextController.text != "Họ và tên" &&
          phoneNumberTextController.text != "Số điện thoại") {
        return true;
      } else {
        return false;
      }
    }
  }

  List<String> splitString(String input) {
    List<String> parts = input.split(', ');
    return parts;
  }
}
