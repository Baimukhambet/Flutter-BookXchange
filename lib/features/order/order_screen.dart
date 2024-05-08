import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_test/extension.dart';
import 'package:cubit_test/features/auth/widgets/input_field.dart';
import 'package:cubit_test/features/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final TextEditingController _getBookController = TextEditingController();
  final TextEditingController _giveBookController = TextEditingController();

  final OrderBloc bloc = OrderBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Order")),
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is OrderInitial) {
            return _buildUI(context, bloc);
          } else if (state is OrderSuccess) {
            return Center(
              child: Text("Order has been created!"),
            );
          } else if (state is OrderFailed) {
            return Center(
              child: Text("Order Failed!"),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildUI(BuildContext context, OrderBloc bloc) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Я хочу получить", style: theme.textTheme.displayLarge),
          24.height,
          InputField(
              hide: false,
              hintText: "Введите название книги",
              controller: _getBookController),
          24.height,
          Text("Взамен я отдам", style: theme.textTheme.displayLarge),
          24.height,
          InputField(
              hide: false,
              hintText: "Введите название книги",
              controller: _giveBookController),
          24.height,
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    bloc.add(OrderCreateTapped(
                        getBookName: _getBookController.text,
                        giveBookName: _giveBookController.text));
                  },
                  child: Text("Подтвердить")))
        ],
      ),
    );
  }
}
