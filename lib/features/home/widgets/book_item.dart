import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Expanded(
                child: Image.network(
              book.imageUrl,
              fit: BoxFit.cover,
            )),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.name, style: theme.textTheme.titleLarge),
                Text(book.category.name),
              ],
            ),
            SizedBox(
                child: TextButton(
              onPressed: () {},
              child: Text("Open Page"),
            ))
          ],
        ));
  }
}
