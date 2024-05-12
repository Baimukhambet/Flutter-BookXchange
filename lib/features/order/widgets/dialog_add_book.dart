import 'dart:async';

import 'package:cubit_test/features/auth/widgets/input_field.dart';
import 'package:cubit_test/repositories/google_library_repository.dart';
import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter/material.dart';

class DialogAddBook extends StatefulWidget {
  DialogAddBook({super.key, required this.controller, required this.book});

  final TextEditingController controller;
  Book? book;

  @override
  State<DialogAddBook> createState() => _DialogAddBookState();
}

class _DialogAddBookState extends State<DialogAddBook> {
  GoogleLibraryRepository googleLib = GoogleLibraryRepository.shared;

  void _findBooks() async {
    books = await googleLib.findBooks(widget.controller.text);
    debugPrint(books.toString());
    setState(() {});
  }

  void _onStopTyping() {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = Timer(duration, () {
      if (widget.controller.text == '') {
        return;
      }
      _findBooks();
    });
  }

  Timer? searchOnStoppedTyping;

  // String query = Publish;

  List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: size.height * 0.5,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            InputField(
              hide: false,
              hintText: 'Название книги',
              controller: widget.controller,
              onChanged: (value) => _onStopTyping(),
            ),
            // TextButton(
            //   child: Text("Find"),
            //   onPressed: () => _findBooks(),
            // ),
            Flexible(
              child: ListView(
                // shrinkWrap: true,
                children: [
                  ...books.map((e) => ListTile(
                        onTap: () {
                          Navigator.of(context).pop<Book>(e);
                        },
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(e.name),
                        leading: e.imageUrl != ''
                            ? Image.network(
                                e.imageUrl,
                              )
                            : Container(
                                color: Colors.grey, height: 40, width: 40),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
