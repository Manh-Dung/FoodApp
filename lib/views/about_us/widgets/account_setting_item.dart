import 'package:flutter/material.dart';

class AccountSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function? onTap;

  const AccountSettingItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.black.withOpacity(0.9)),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.9)),
          ),
        ],
      ),
    );
  }
}
