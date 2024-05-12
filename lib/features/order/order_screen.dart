import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_test/extension.dart';
import 'package:cubit_test/features/auth/widgets/input_field.dart';
import 'package:cubit_test/features/order/bloc/order_bloc.dart';
import 'package:cubit_test/features/order/widgets/add_book_button.dart';
import 'package:cubit_test/features/order/widgets/dialog_add_book.dart';
import 'package:cubit_test/features/order/widgets/get_book_item.dart';
import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  Timer? _onStopTyping;

  final TextEditingController _getBookController = TextEditingController();
  final TextEditingController _giveBookController = TextEditingController();

  final OrderBloc bloc = OrderBloc();

  bool bookIsChosen = false;

  void _onInputChange() {
    const duration = Duration(milliseconds: 800);
    if (_onStopTyping != null) {
      _onStopTyping?.cancel();
    }
    _onStopTyping = Timer(
        duration,
        () =>
            bloc.add(OrderFindBookTapped(bookName: _giveBookController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Создать Пост", style: theme.textTheme.titleLarge),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          bloc: bloc,
          builder: (context, state) {
            return _buildUI(context, bloc);
          },
        ),
      ),
    );
  }

  void _showAddBookDialog(BuildContext context) {
    Book? getBook;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: DialogAddBook(
          controller: _getBookController,
          book: getBook,
        ),
      ),
    ).then((value) {
      debugPrint("Dismissed");
      if (value is Book) {
        FocusScope.of(context).unfocus();
        debugPrint("You chose" + value.name);
        _getBookController.clear();
        bloc.add(OrderGetBookChosen(book: value));
      }
    });
  }

  Widget _buildUI(BuildContext context, OrderBloc bloc) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                bloc: bloc,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //INPUT FIELD
                      if (state.giving == null)
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                hide: false,
                                hintText: "Название книги",
                                controller: _giveBookController,
                                onChanged: (value) => _onInputChange(),
                              ),
                            ),
                          ],
                        ),
                      24.height,

                      // List found books
                      if (state.giving == null && state.found_books.isNotEmpty)
                        Flexible(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: ListView(
                              // shrinkWrap: true,
                              children: [
                                ...state.found_books.map((e) => ListTile(
                                      onTap: () {
                                        _giveBookController.clear();
                                        bloc.add(OrderFoundBookTapped(
                                            book: Book(
                                                category: Category.all,
                                                name: e.name,
                                                imageUrl: e.imageUrl)));
                                      },
                                      contentPadding: const EdgeInsets.all(8),
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
                        )
                      else if (state.isLoading)
                        const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )

                      //ERROR MESSAGE
                      else if (state.hasError)
                        Center(
                          child: Text(
                              state.errorMessage ?? "no message but error"),
                        )

                      //Chosen
                      else if (state.giving != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(state.giving!.imageUrl,
                                      fit: BoxFit.cover),
                                ),
                                18.width,
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        state.giving!.name,
                                        style: theme.textTheme.displayLarge,
                                        maxLines: 10,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            24.height,
                            GestureDetector(
                              onTap: () => bloc.add(OrderCancelBookTapped()),
                              child: Text("Отменить выбор",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5158FF))),
                            )
                          ],
                        )
                      else
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                "Книга не выбрана",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ))),
                        ),
                    ],
                  );
                },
              ),
            ),
            24.height,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Обменяю на', style: theme.textTheme.titleLarge),
                  24.height,
                  Expanded(
                    child: BlocBuilder<OrderBloc, OrderState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (state.taking.isNotEmpty)
                            ...state.taking.map(
                              (e) {
                                return Flexible(child: GetBookItem(book: e));
                              },
                            ),
                            if (state.taking.length < 3)
                              AddBookButton(
                                onTap: () {
                                  _showAddBookDialog(context);
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                child: const Text("Создать")),
            14.height
          ],
        ),
      ),
    );
  }
}


//гарри поттер и узник азкабана
