import 'package:ints/base/base_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}

class LanguageController extends BaseController {
  RxBool isVietnameseChecked = RxBool(true);
  RxBool isToggled = RxBool(false);
  void toggleLanguage() {
    isToggled.value = true;
    isVietnameseChecked.value = !isVietnameseChecked.value;
  }
}
