import 'package:flutter/material.dart';

class NotificationAlertWidget extends StatelessWidget {
  final String title;
  final String body;
  const NotificationAlertWidget(
      {super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(title), Text(body)],
    );
  }
}
