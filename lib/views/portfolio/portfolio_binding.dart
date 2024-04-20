import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/local/data_source/portfolio_datasource.dart';
import 'package:ints/models/portfolio.dart';
import 'package:ints/x_utils/widgets/my_text_form_field.dart';

class PortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortfolioController());
  }
}

class PortfolioController extends BaseController {
  late PortfolioDataSource _dataSource;
  late RxList<Portfolio> portfolios = RxList();
  TextEditingController name = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _dataSource = PortfolioDataSource();
    onGetPortfolios();
  }

  void onGetPortfolios() async {
    setScreenState = screenStateLoading;
    try {
      portfolios.value = await _dataSource.getAll();
      setScreenState = screenStateOk;
    } catch (e) {
      setScreenState = screenStateError;
    }
    update();
  }

  void deleteAll() async {
    setScreenState = screenStateLoading;
    try {
      await _dataSource.deleteAll();
      portfolios.clear();
      setScreenState = screenStateOk;
    } catch (e) {
      setScreenState = screenStateError;
    }
    update();
  }

  void onCreate() {
    showAlert(
        title: "Create portfolio",
        content: MyTextFormField(
          controller: name,
          labelText: "Name",
          hint: "Portfolio name",
        ),
        barrierDismissible: false,
        confirmTextColor: Colors.white,
        textConfirm: "Create",
        textCancel: "Cancel",
        onWillPop: null,
        onConfirm: () {
          try {
            hideDialog();
            Portfolio data = Portfolio(name: name.text);
            _dataSource.insert(data).then((value) {
              showSuccessSnackBar(title: "Success", message: "Create success");
              onGetPortfolios();
            });
          } catch (e) {
            showErrorSnackBar(
                title: "Error", message: 'XR().string.error_message');
          } finally {
            name.text = "";
          }
          update();
        },
        onCancel: () {
          hideDialog();
        },
        actions: []);
  }
}
