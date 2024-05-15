import 'package:cubit_test/extension.dart';
import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(book.imageUrl),
        10.width,
        Flexible(
            child: Text(book.name,
                maxLines: 4, style: theme.textTheme.titleMedium))
      ],
    ));
  }
}
