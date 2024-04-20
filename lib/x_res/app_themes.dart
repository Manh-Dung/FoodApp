import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ints/x_res/app_text_style.dart';

import 'my_res.dart';

/// Created by daewubintara on
/// 08, September 2020 16.17

class AppThemes {
  final String _sThemeModeKey = 'S_THEME_MODE_KEY';
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';
  static String Poppins = "Poppins";
  static String Roboto = "Roboto";
  static String NotoSansJP = "NotoSansJP";
  static String QuicksandRegular = "QuicksandRegular";
  static String QuicksandMedium = "QuicksandMedium";

  static String _fontFamily = Roboto;

  // LIGHT THEME TEXT
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    displayMedium: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    displaySmall: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    headlineSmall: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    titleLarge: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    labelSmall: AppTextStyle.blackS10.copyWith(fontFamily: _fontFamily),
  );

  // DARK THEME TEXT
  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    displayMedium: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    displaySmall: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    headlineSmall: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    titleLarge: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    labelSmall: AppTextStyle.whiteS10.copyWith(fontFamily: _fontFamily),
  );

  // LIGHT THEME
  static final ThemeData _lightTheme = ThemeData(
    fontFamily: _fontFamily,
    primaryColor: MyColor.PRIMARY_COLOR,
    scaffoldBackgroundColor: MyColor.LIGHT_BACKGROUND_COLOR,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColor.PRIMARY_COLOR,
    ),
    appBarTheme: AppBarTheme(
      color: MyColor.PRIMARY_COLOR,
      iconTheme: IconThemeData(color: MyColor.ICON_COLOR),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MyColor.white,
        selectedLabelStyle: AppTextStyle.blackS10,
        unselectedLabelStyle: AppTextStyle.blackS10),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: MyColor.LIGHT_BACKGROUND_COLOR),
    iconTheme: IconThemeData(
      color: MyColor.ICON_COLOR,
    ),
    popupMenuTheme: PopupMenuThemeData(color: MyColor.LIGHT_BACKGROUND_COLOR),
    textTheme: _lightTextTheme,
    colorScheme: ColorScheme.light(
        primary: MyColor.PRIMARY_COLOR, secondary: MyColor.ACCENT_COLOR),
  );

  // DARK THEME
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    primaryColor: MyColor.PRIMARY_DARK_COLOR,
    scaffoldBackgroundColor: MyColor.DARK_BACKGROUND_COLOR,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColor.PRIMARY_DARK_COLOR,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: MyColor.black_80,
      selectedLabelStyle: AppTextStyle.whiteS10,
      unselectedLabelStyle: AppTextStyle.greyS10,
    ),
    appBarTheme: AppBarTheme(
      color: MyColor.PRIMARY_DARK_COLOR,
      iconTheme: IconThemeData(color: MyColor.ICON_COLOR_DARK),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: MyColor.DARK_BACKGROUND_COLOR),
    iconTheme: IconThemeData(
      color: MyColor.ICON_COLOR_DARK,
    ),
    popupMenuTheme: PopupMenuThemeData(color: MyColor.DARK_BACKGROUND_COLOR),
    textTheme: _darkTextTheme,
    colorScheme: ColorScheme.dark(
        primary: MyColor.PRIMARY_DARK_COLOR, secondary: MyColor.ACCENT_COLOR),
  );

  /// LIGHT THEME
  static ThemeData theme() {
    return _lightTheme;
  }

  /// DARK THEME
  static ThemeData darkTheme() {
    return _darkTheme;
  }

  ///
  /// [AppThemes] initiation.
  /// Please Add [AppThemes().init() into GetMaterialApp.
  ///
  /// [Example] :
  ///
  /// GetMaterialApp(
  ///   themeMode: AppThemes().init(),
  /// )
  ///
  /// This [Function] works to initialize what theme is used.
  ThemeMode init() {
    final box = GetStorage();
    String? tm = box.read(_sThemeModeKey);
    if (tm == null) {
      box.write(_sThemeModeKey, _sThemeModeLight);
      return ThemeMode.light;
    } else if (tm == _sThemeModeLight) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    final box = GetStorage();
    if (themeMode == ThemeMode.dark) {
      box.write(_sThemeModeKey, _sThemeModeDark);
    } else {
      box.write(_sThemeModeKey, _sThemeModeLight);
    }
    Get.changeThemeMode(themeMode);
    Get.rootController.themeMode.reactive;
  }

  ///
  /// [ThemeData] general.
  ///
  /// [Example] :
  ///
  /// Text("Hello, world",
  ///   style: AppThemes().general().textTheme.bodyText1,
  /// )
  ///
  /// This [Function] is useful for styling widgets.
  ///
  /// [Function] AppThemes().general().*
  /// has several derivative functions.
  ThemeData general() {
    final box = GetStorage();
    String tm = box.read(_sThemeModeKey);
    if (tm == _sThemeModeLight) {
      return _lightTheme;
    }
    return _darkTheme;
  }
}
