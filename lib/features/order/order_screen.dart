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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Создать Пост", style: theme.textTheme.titleLarge),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: bloc,
        builder: (context, state) {
          // if (state is OrderInitial) {
          //   return _buildUI(context, bloc);
          // } else if (state is OrderSuccess) {
          //   return Center(
          //     child: Text("Order has been created!"),
          //   );
          // } else if (state is OrderFailed) {
          //   return Center(
          //     child: Text("Order Failed!"),
          //   );
          // }
          // return Center(child: CircularProgressIndicator());
          return _buildUI(context, bloc);
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
          16.height,
          Row(
            children: [
              Expanded(
                child: InputField(
                    hide: false,
                    hintText: "Название книги",
                    controller: _getBookController),
              ),
              TextButton(
                child: Text("Найти"),
                onPressed: () {
                  bloc.add(
                      OrderFindBookTapped(bookName: _getBookController.text));
                },
              )
            ],
          ),
          24.height,
          BlocBuilder<OrderBloc, OrderState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is OrderBooksLoaded) {
                return Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView(
                      // shrinkWrap: true,
                      children: [
                        ...state.books.map((e) => ListTile(
                              contentPadding: EdgeInsets.all(8),
                              title: Text(e.name),
                              leading: e.imageUrl != ''
                                  ? Image.network(
                                      e.imageUrl,
                                    )
                                  : Container(
                                      color: Colors.grey,
                                      height: 40,
                                      width: 40),
                            ))
                      ],
                    ),
                  ),
                );
              } else if (state is OrderBooksFailure) {
                return Center(
                  child: Text(state.message ?? "no message but error"),
                );
              } else if (state is OrderInitial) {
                return SizedBox();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
