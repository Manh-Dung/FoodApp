import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/portfolio/portfolio_binding.dart';
import 'package:ints/x_res/my_res.dart';

class PortfolioScreen extends BaseView<PortfolioController> {
  @override
  Widget vBuilder() => Scaffold(
        appBar: AppBar(
          title: Text("{XR().string.portfolio_title}"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: controller.onCreate,
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: controller.deleteAll, child: Text("Delete All")),
            _body()
          ],
        ),
      );

  _body() {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());

    if (controller.screenStateIsError) return Text('XR().string.error_message');

    if (controller.screenStateIsOK)
      return Container(
        child: Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: controller.portfolios.length,
              itemBuilder: (context, index) {
                return Text(controller.portfolios[index].name!);
              }),
        ),
      );
  }
}
