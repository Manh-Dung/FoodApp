import 'package:ints/base/base_controller.dart';

class ChatPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatPageController());
  }
}

class ChatPageController extends BaseController {
  final List<String> chatList = [
    'Xin chào! Mặt hàng này còn không shop!',
    'Cảm ơn shop nhiều,',
    'Cảm ơn shop nhiều,',
    'Cảm ơn shop nhiều,'
  ];
  bool isAvailableNoti = true;

  @override
  void onReady() {
    super.onReady();
  }
}
