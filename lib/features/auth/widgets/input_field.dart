import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.hide,
      required this.hintText,
      required this.controller});

  final bool hide;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hide,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}
