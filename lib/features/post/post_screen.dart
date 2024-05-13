import 'package:cubit_test/repositories/models/trade_order.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.order}) : super(key: key);

  final TradeOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Image.network(order.giving.imageUrl),
          )
        ],
      ),
    );
  }
}
