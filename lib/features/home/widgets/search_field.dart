import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.all(8),
          hintText: "Название книги",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}
