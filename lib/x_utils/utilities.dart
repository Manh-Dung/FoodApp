import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product/product.dart';
import '../x_res/my_res.dart';

///
/// --------------------------------------------
/// There are many amazing [Function]s in this class.
/// Especialy in [Function]ality.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class Utilities {
  void callPhoneNumber({String phone = "0"}) async {
    launch("tel://${phone}");
  }

  void intentOpenUrl({String link = "https://google.com"}) async {
    final url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String moneyFormater(String? value) {
    if (value == null || value == 'null') {
      value = "0";
    }

    double amount = double.parse(value);
    // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
    // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
    // String fix = "" + c.replaceAll(",", ".");
    NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    // return value;
    return formatter.format(amount);
  }

  String formatDate(String dateStr) {
    if (dateStr == 'null') {
      return "";
    }
    DateTime date = DateTime.parse(dateStr);
    return '${date.hour}:${date.minute} - ${date.day}/${date.month}/${date.year}';
  }

  String formattedDate({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  String formattedDateGetDay({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('EEEE').format(dateTime);
    switch (formattedDate) {
      case "Monday":
        formattedDate = "Senin";
        break;
      case "Tuesday":
        formattedDate = "Selasa";
        break;
      case "Wednesday":
        formattedDate = "Rabu";
        break;
      case "Thursday":
        formattedDate = "Kamis";
        break;
      case "Friday":
        formattedDate = "Jum'at";
        break;
      case "Saturday":
        formattedDate = "Sabtu";
        break;
      case "Sunday":
        formattedDate = "Minggu";
        break;
    }

    return formattedDate;
  }

  String formattedDateGetMonth({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('MMMM').format(dateTime);
    switch (formattedDate) {
      case "January":
        formattedDate = "Januari";
        break;
      case "February":
        formattedDate = "Februari";
        break;
      case "March":
        formattedDate = "Maret";
        break;
      case "April":
        formattedDate = "April";
        break;
      case "May":
        formattedDate = "Mei";
        break;
      case "June":
        formattedDate = "Juni";
        break;
      case "July":
        formattedDate = "Juli";
        break;
      case "August":
        formattedDate = "Agustus";
        break;
      case "September":
        formattedDate = "September";
        break;
      case "October":
        formattedDate = "Oktober";
        break;
      case "November":
        formattedDate = "November";
        break;
      case "December":
        formattedDate = "Desember";
        break;
    }

    return formattedDate;
  }

  String formattedSimpleDate({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String formattedSuperSimpleDate({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMM').format(dateTime);
    return formattedDate;
  }

  String formattedDateTimeWithDay({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String day = formattedDateGetDay(format: format, date: date);

    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
    return '${day}, ${formattedDate}';
  }

  String formattedDateTime({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
    return formattedDate;
  }

  String formattedTime({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('HH:mm').format(dateTime);
    return formattedDate;
  }

  String formattedSimpleDateTime({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMM yyyy HH:mm').format(dateTime);
    return formattedDate;
  }

  String parseHtmlString(String htmlString) {
    // var document = parse(htmlString);
    // String parsedString = parse(document.body.text).documentElement.text;
    return htmlString;
  }

  Future<String> getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    if (Platform.isAndroid) {
      return "Version " + version;
    } else {
      return "Version " + version;
    }
  }

  String stringCardFormated({String value = "", int splitOn = 3, String modelSplit = " "}) {
    String newValue = "Error Formating";
    if (value.length < splitOn) {
      newValue = value;
    } else {
      int startIndex = 0;
      int endIndex = splitOn;
      newValue = _formating(startIndex, endIndex, value, "", splitOn, modelSplit);
    }
    return newValue;
  }

  String _formating(
      int startIndex, int endIndex, String value, String temp, int splitOn, String modelSplit) {
    if (startIndex == 0 && endIndex >= value.length) {
      temp = value.substring(startIndex, endIndex);
      return temp;
    }
    if (startIndex == 0 && endIndex < value.length) {
      temp = value.substring(startIndex, endIndex);
      startIndex += splitOn;
      endIndex += splitOn;
      return _formating(startIndex, endIndex, value, temp, splitOn, modelSplit);
    }
    if (startIndex < value.length && endIndex < value.length) {
      temp += "$modelSplit" + value.substring(startIndex, endIndex);
      startIndex += splitOn;
      endIndex += splitOn;
      return _formating(startIndex, endIndex, value, temp, splitOn, modelSplit);
    } else {
      temp += "$modelSplit" + value.substring(startIndex, value.length);
      return temp;
    }
  }

  Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    }
    // else if (color.length == 8) {
    //   return Color(int.parse("0x" + color));
    // }
    return Color(int.parse("0x" + color));
  }

  String stringSliptedConvertToSentence(String string, String splitter) {
    string = string.replaceAll("$splitter", " ");
    string = string.capitalizeFirstofEach;
    return string;
  }

  void logWhenDebug(String tag, String message) {
    if (kDebugMode) log("$tag => ${message.toString()}", name: MyConfig.APP_NAME);
  }

  String convertToYYYYMMDD(String inputDate) {
    // Chuyển đổi chuỗi thành DateTime
    List<String> dateParts = inputDate.split('-');
    if (dateParts.length != 3) {
      // Trường hợp không phải định dạng ngày tháng năm đúng
      return 'Invalid Date Format';
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    // Tạo DateTime từ các phần tử
    DateTime dateTime = DateTime(year, month, day);

    // Chuyển đổi DateTime thành chuỗi định dạng 'YYYY-MM-DD'
    String formattedDate =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return formattedDate;
  }

  List<int> findMaxMinPrice(List<Prices> prices) {
    List<int> listPrice = [];
    var max = int.parse(prices[0].price ?? "0");
    var maxIndex = 0;
    var min = int.parse(prices[0].price ?? "0");
    var minIndex = 0;

    for (var i = 0; i < prices.length.toInt(); i++) {
      if (int.parse(prices[i].price ?? "0") > max) {
        max = int.parse(prices[i].price ?? "0");
        maxIndex = i;
      }
      if (int.parse(prices[i].price ?? "0") < min) {
        min = int.parse(prices[i].price ?? "0");
        minIndex = i;
      }
    }

    listPrice.add(minIndex);
    listPrice.add(maxIndex);

    return listPrice;
  }

  num totalInventory(List<Prices> prices) {
    num total = 0;
    for (var i = 0; i < prices.length.toInt(); i++) {
      total += prices[i].inventory ?? 0;
    }
    return total;
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach => this.split(" ").map((str) => str.capitalize).join(" ");
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
