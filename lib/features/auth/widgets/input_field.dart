import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Container(
        decoration: BoxDecoration(
            color: Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(8)),
        child: TextField(
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
          controller: controller,
          obscureText: hide,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            hintText: hintText,
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ));
  }
}
