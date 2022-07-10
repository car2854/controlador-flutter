import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String labelText;
  final Icon? iconData;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType textInputType;

  const TextFieldWidget({
    Key? key, 
    required this.labelText, 
    required this.controller,
    this.iconData, 
    this.isPassword = false, 
    this.textInputType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,
        icon: (iconData != null) ? iconData : const SizedBox()
      ),
      obscureText: isPassword,
      controller: controller,
    );
  }
}