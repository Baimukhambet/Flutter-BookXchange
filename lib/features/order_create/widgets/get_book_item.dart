import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GetBookItem extends StatelessWidget {
  const GetBookItem({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 4000,
        // width: 100,
        margin: EdgeInsets.only(right: 18),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  book.imageUrl,
                  height: 140,
                  // width: 100,
                  fit: BoxFit.fill,
                )),
            Text(book.name, style: TextStyle(overflow: TextOverflow.ellipsis))
          ],
        ));
  }
}
