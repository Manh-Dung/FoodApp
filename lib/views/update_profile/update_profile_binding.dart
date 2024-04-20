import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ints/base/base_controller.dart';

import '../app/app_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController());
  }
}

class UpdateProfileController extends BaseController {
  AppController appController = Get.find();
  Rx<String> rxFullName = Rx<String>("");
  Rx<String> rxPhoneNumber = Rx<String>("");
  Rx<String> rxEmail = Rx<String>("");
  RxBool rxIsUpdated = RxBool(false);
  Rxn<File> rxFile = Rxn<File>();
  RxString rxFilePath = RxString("");

  @override
  void onInit() {
    super.onInit();
    rxFullName.value = appController.rxUser.value?.fullName ?? '';
    rxPhoneNumber.value = appController.rxUser.value?.phoneNumber ?? '';
    rxEmail.value = appController.rxUser.value?.email ?? '';
  }

  Future updateProfile() async {
    showLoadingDialog();

    try {
      List<String> files = [rxFilePath.value];
      await userRepositories.updateUser(fullName: rxFullName.value, paths: files);

      rxIsUpdated.value = false;
      hideDialog();
      await appController.getUserInfor();
      while (Get.currentRoute != RouterName.home) {
        Get.back();
      }
    } catch (e) {
      handleErr(e);
      hideDialog();
    }
  }

  void onPickImage() async {
    var returnImages = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImages != null) {
      postFiles(files: [File(returnImages.path)]);
      rxFile.value = File(returnImages.path);
    }
  }

  Future postFiles({required List<File?> files}) async {
    showLoadingDialog();
    try {
      var res = await fileRepositories.postFiles(files: files);
      rxFilePath.value = res[0].path!;

      hideDialog();
    } catch (e) {
      hideDialog();
      print(e.toString());
    }
  }
}
