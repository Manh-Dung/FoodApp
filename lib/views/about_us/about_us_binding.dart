import 'package:ints/base/base_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}

class AboutUsController extends BaseController {
  Rx<String> rxTitle = Rx(Get.arguments['title']);

}
