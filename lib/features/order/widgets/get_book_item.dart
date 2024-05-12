import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GetBookItem extends StatelessWidget {
  const GetBookItem({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 100,
        margin: EdgeInsets.only(right: 14),
        child: Column(
          children: [
            Flexible(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.imageUrl,
                  )),
            ),
            Text(book.name, style: TextStyle(overflow: TextOverflow.ellipsis))
          ],
        ));
  }
}
