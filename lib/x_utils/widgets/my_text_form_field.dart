import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/x_utils/validator_util.dart';

import '../currency_input_formater.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  ValueChanged<String>? onChanged;
  String labelText;
  String initialText;
  String hint;
  FocusNode? focusNode;
  FocusNode? focusNodeNext;
  bool obscureText;
  bool inputNumber;
  bool currencyMode;
  bool _withIconShowHideText = false;
  int maxLength;
  int maxLines;
  Widget? prefixIcon;
  bool isEmail;
  bool isName;
  bool alwaysFloatLabel;
  bool isEnabled;
  TextEditingController? controller;
  FormFieldSetter<String>? onSaved;
  String isOTP;

  MyTextFormField({
    this.onChanged,
    this.labelText = "Label",
    this.prefixIcon,
    this.hint = "",
    this.initialText = "",
    this.focusNode,
    this.focusNodeNext,
    this.maxLength = 255,
    this.maxLines = 1,
    this.onSaved,
    this.controller,
    this.isEmail = false,
    this.isName = false,
    this.alwaysFloatLabel = false,
    this.isEnabled = true,
    this.currencyMode = false,
    this.inputNumber = false,
    this.obscureText = false,
    this.isOTP = "",
  });

  @override
  Widget build(BuildContext context) {
    if (obscureText) {
      _withIconShowHideText = true;
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          children: [
            controller == null
                ? TextFormField(
                    controller: null,
                    enabled: isEnabled,
                    validator: (val) {
                      if (val == '' || val == null) {
                        return ('$labelText' + XR().string.cannot_be_empty);
                      } else {
                        if (Validator().email(val) == false && isEmail == true) {
                          return XR().string.email_is_invalid;
                        } else {
                          return null;
                        }
                      }
                    },
                    maxLength: maxLength,
                    onChanged: onChanged,
                    focusNode: focusNode,
                    onSaved: onSaved,
                    onFieldSubmitted: (val) {
                      if (focusNodeNext != null) {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(focusNodeNext);
                      } else {
                        FocusScope.of(context).unfocus();
                        return FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    initialValue: initialText,
                    maxLines: maxLines,
                    obscureText: obscureText,
                    textInputAction: focusNodeNext != null
                        ? TextInputAction.next
                        : (maxLines > 1 ? TextInputAction.newline : TextInputAction.done),
                    keyboardType: inputNumber == true
                        ? TextInputType.number
                        : (isEmail
                            ? TextInputType.emailAddress
                            : (isName
                                ? TextInputType.name
                                : (maxLines > 1 ? TextInputType.multiline : TextInputType.text))),
                    inputFormatters: inputNumber == true
                        ? currencyMode == true
                            ? [FilteringTextInputFormatter.digitsOnly, CurrencyInputFormatter()]
                            : [FilteringTextInputFormatter.digitsOnly]
                        : null,
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_LABEL_COLOR,
                        ),
                        counterText: "",
                        labelText: "$labelText",
                        floatingLabelBehavior: alwaysFloatLabel == true
                            ? FloatingLabelBehavior.always
                            : FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyColor.TEXT_LABEL_COLOR,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                        focusColor: MyColor.black,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColor.INPUT_FORM_COLOR,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColor.INPUT_FORM_COLOR,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: isEnabled ? Colors.transparent : MyColor.DISABLE_TEXT_FIELD,
                        prefixIcon: prefixIcon),
                  )
                : TextFormField(
                    controller: controller,
                    enabled: isEnabled,
                    // initialValue: initialText,
                    validator: (val) {
                      if (val == '' || val == null) {
                        return ('$labelText' + XR().string.cannot_be_empty);
                      } else {
                        if (Validator().email(val) == false && isEmail == true) {
                          return XR().string.email_is_invalid;
                        } else {
                          return null;
                        }
                        return null;
                      }
                    },
                    maxLength: maxLength,
                    onChanged: onChanged,
                    focusNode: focusNode,
                    onSaved: onSaved,
                    onFieldSubmitted: (val) {
                      if (focusNodeNext != null) {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(focusNodeNext);
                      } else {
                        FocusScope.of(context).unfocus();
                        return FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    // initialValue: initialText,
                    maxLines: maxLines,
                    obscureText: obscureText,
                    textInputAction: focusNodeNext != null
                        ? TextInputAction.next
                        : (maxLines > 1 ? TextInputAction.newline : TextInputAction.done),
                    keyboardType: inputNumber == true
                        ? TextInputType.number
                        : (maxLines > 1 ? TextInputType.multiline : TextInputType.text),
                    // inputFormatters: inputNumber == true
                    //     ? (currencyMode == true
                    //         ? [
                    //             WhitelistingTextInputFormatter.digitsOnly,
                    //             CurrencyInputFormatter()
                    //           ]
                    //         : [WhitelistingTextInputFormatter.digitsOnly])
                    //     : null,
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_LABEL_COLOR,
                        ),
                        counterText: "",
                        labelText: "$labelText",
                        floatingLabelBehavior: alwaysFloatLabel == true
                            ? FloatingLabelBehavior.always
                            : FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: MyColor.TEXT_LABEL_COLOR,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                        focusColor: MyColor.black,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColor.INPUT_FORM_COLOR,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyColor.INPUT_FORM_COLOR,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: isEnabled ? Colors.transparent : MyColor.DISABLE_TEXT_FIELD,
                        prefixIcon: prefixIcon),
                  ),
            _withIconShowHideText == false
                ? Container()
                : Positioned(
                    right: 5,
                    top: 0,
                    child: IconButton(
                      icon: obscureText == true
                          ? Icon(Icons.visibility, color: Color(0xff949499))
                          : Icon(
                              Icons.visibility_off,
                              color: MyColor.TEXT_LABEL_COLOR,
                            ),
                      onPressed: () {
                        setState(() {
                          if (obscureText == true) {
                            obscureText = false;
                          } else {
                            obscureText = true;
                          }
                        });
                      },
                    ),
                  )
          ],
        );
      },
    );
  }
}
