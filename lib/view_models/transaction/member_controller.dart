import 'package:ints/base/base_controller.dart';
import 'package:ints/views/test/test_binding.dart';



class MemberController extends BaseController {
  var count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setWiState = stateError;
    logWhenDebug("STATE ON INIT", getWiState.toString());
  }

  void increment() => count++;

  void changeState() {
    if (wiStateIsLoading) {
      setWiState = stateError;
      logWhenDebug("STATE LOADING", wiStateIsLoading.toString());
      return;
    }
    if (wiStateIsError) {
      setWiState = stateOk;
      logWhenDebug("STATE ERROR", wiStateIsError.toString());
      return;
    }
    if (wiStateIsOK) {
      setWiState = stateLoading;
      logWhenDebug("STATE OK", wiStateIsOK.toString());
      return;
    }
  }

  void changeLanguage() {
    String lang = box.read(MyConfig.LANGUAGE);
    if (lang == 'id') {
      MyTranslations.updateLocale(langCode: 'en');
    } else {
      MyTranslations.updateLocale(langCode: 'vi');
    }
    try {
      TestController testController = Get.find();
      testController.onInit();
    } catch (e) {}
  }
}
