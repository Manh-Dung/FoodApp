import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../app/app_controller.dart';

class UpdateFullNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateFullNameController());
  }
}

class UpdateFullNameController extends BaseController {
  final appController = Get.find<AppController>();
  late TextEditingController fullNameTextController;

  @override
  void onInit() {
    super.onInit();

    fullNameTextController = TextEditingController(text: appController.rxUser.value?.fullName);
  }
}
