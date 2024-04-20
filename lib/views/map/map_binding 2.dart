import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/create_address/create_address_binding.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => CreateAddressController());
  }
}

class MapController extends BaseController {
  final createAddressController = Get.find<CreateAddressController>();
  RxString rxSelectedLocation = RxString("");

  double latitude = 0;
  double longtitude = 0;
  @override
  void onInit() {
    super.onInit();
    getCurrentPostion().then((value) {
      latitude = value.latitude;
      longtitude = value.longitude;
    });
  }

  Future<Position> getCurrentPostion() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<Location> getCoordinatesFromAddress(String text) async {
    List<Location> locations = await locationFromAddress(text);
    return locations.first;
  }

  void setCurrentAddress(String currentAddress) {
    List<String> addressNameParts = currentAddress.split(', ');

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
      createAddressController.addressDetailTextController.text = detailAddress;
      createAddressController.rxIsEnableBtn.value = true;
      while (Get.currentRoute != RouterName.create_address) {
        Get.back(result: rxSelectedLocation.value);
      }
    } else if (addressNameParts.length == 5) {
      addressNameParts.removeRange(
          addressNameParts.length - 2, addressNameParts.length);
      String currentAddress = addressNameParts.join(', ');
      getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
        createAddressController.rxSelectedLatitude.value = value.latitude;
        createAddressController.rxSelectedLongitude.value = value.longitude;
      });
      rxSelectedLocation.value = currentAddress;

      while (Get.currentRoute != RouterName.create_address) {
        Get.back(result: rxSelectedLocation.value);
      }
    } else if (addressNameParts.length == 4) {
      if (int.tryParse(addressNameParts[addressNameParts.length - 2]) != null) {
        addressNameParts.removeRange(
            addressNameParts.length - 2, addressNameParts.length);

        rxSelectedLocation.value = addressNameParts.join(', ');
        getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
          createAddressController.rxSelectedLatitude.value = value.latitude;
          createAddressController.rxSelectedLongitude.value = value.longitude;
        });
        while (Get.currentRoute != RouterName.create_address) {
          Get.back(result: rxSelectedLocation.value);
        }
      } else {
        addressNameParts.removeRange(
            addressNameParts.length - 1, addressNameParts.length);
        rxSelectedLocation.value = addressNameParts.join(', ');
        getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
          createAddressController.rxSelectedLatitude.value = value.latitude;
          createAddressController.rxSelectedLongitude.value = value.longitude;
        });
        while (Get.currentRoute != RouterName.create_address) {
          Get.back(result: rxSelectedLocation.value);
        }
      }
    } else if (addressNameParts.length == 3) {
      addressNameParts.removeRange(
          addressNameParts.length - 1, addressNameParts.length);
      rxSelectedLocation.value = addressNameParts.join(', ');
      getCoordinatesFromAddress(addressNameParts.join(', ')).then((value) {
        createAddressController.rxSelectedLatitude.value = value.latitude;
        createAddressController.rxSelectedLongitude.value = value.longitude;
      });
      while (Get.currentRoute != RouterName.create_address) {
        Get.back(result: rxSelectedLocation.value);
      }
    }
  }
}
