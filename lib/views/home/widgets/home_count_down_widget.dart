import 'package:flutter/material.dart';

class HomeCountDownWidget extends StatelessWidget {
  final int hour;
  final int minute;
  final int second;

  const HomeCountDownWidget(
      {super.key, required this.hour, required this.minute, required this.second});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTime(hour),
        const SizedBox(width: 4.0),
        _buildTime(minute),
        const SizedBox(width: 4.0),
        _buildTime(second),
      ],
    );
  }

  _buildTime(int time) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        time.toString().padLeft(2, '0'),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
