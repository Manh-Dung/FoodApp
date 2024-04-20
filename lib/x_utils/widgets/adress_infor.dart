import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
 // final String hintText;
  final String text;


  const AddressTextField({
    Key? key,
    required this.controller,
   // required this.hintText,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Text(text),
              Text("*",style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 45,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
              //  hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                 borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),


              ),
            textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ),
      ],
    );
  }
}
