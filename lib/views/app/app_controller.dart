import 'package:ints/base/base_controller.dart';

import '../../models/auth/user.dart';
import '../../x_utils/get_storage_util.dart';

class AppController extends BaseController {
  Rxn<User> rxUser = Rxn();

  RxBool isLogin =
      RxBool(ShareStorage.storage.read(MyConfig.ACCESS_TOKEN_KEY) != null);

  @override
  void onInit() {
    super.onInit();
    if (isLogin.value) {
      getUserInfor();
    }
  }

  Future<bool> getUserInfor() async {
    try {
      var res = await authRepositories.getUserInfor();
      rxUser.value = res;
      return true;
    } catch (e) {
      handleErr(e);
      return false;
    }
  }
}
