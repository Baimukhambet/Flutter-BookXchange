import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({super.key, required this.onTap, required this.title});

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white),
        child: Text(title));
  }
}
