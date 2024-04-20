import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

class AddressTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconButton? icon;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  const AddressTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.textInputAction,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bạn chưa nhập thông tin ${widget.hintText}';
        }
        return null;
      },
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColor.TEXT_COLOR_NEW),
      decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 80),
          hintText: widget.hintText,
          hintStyle:
              TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: MyColor.HINT_TEXT_COLOR),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          suffixIcon: widget.icon),
    );
  }
}
