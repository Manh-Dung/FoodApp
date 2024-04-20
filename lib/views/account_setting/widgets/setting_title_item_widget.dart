import 'package:flutter/widgets.dart';

import '../../../base/base_view_view_model.dart';

class SettingTitleItemWidget extends StatelessWidget {
  final String title;
  const SettingTitleItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColor.BACKGROUND_COLOR,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          '$title',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyColor.BORDER_COLOR,
          ),
        ));
  }
}
