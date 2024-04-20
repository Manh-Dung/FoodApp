import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'about_us_binding.dart';

class AboutUsScreen extends BaseView<AboutUsController> {
  @override
  Widget vBuilder() => Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Text(
                loremIpsum(paragraphs: 5, words: 500),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text(controller.rxTitle.value,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
