import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ints/x_res/language/vi_VN.dart';

import 'language/en_US.dart';
import 'language/ja_JP.dart';
import 'my_config.dart';

class MyTranslations extends Translations {
  // Default locale
  static final locale = Locale('vi');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('vi');

  static void init() {
    final box = GetStorage();
    String? locale = box.read(MyConfig.LANGUAGE);
    if (locale == null) {
      Get.updateLocale(Locale('vi'));
      box.write(MyConfig.LANGUAGE, 'vi');
    } else {
      Get.updateLocale(Locale(locale));
    }
  }

  static void updateLocale({required String langCode}) {
    final box = GetStorage();
    Get.updateLocale(Locale(langCode));
    box.write(MyConfig.LANGUAGE, langCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {'ja': ja_JP, 'en': en_US, "vi": vi_VN};
}
