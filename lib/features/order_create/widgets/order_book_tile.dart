import 'package:flutter/material.dart';

class OrderBookTile extends StatelessWidget {
  const OrderBookTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [Image.network('src')],
      ),
    );
  }
}
