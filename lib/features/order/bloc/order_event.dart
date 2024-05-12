part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderCreateTapped extends OrderEvent {
  final String getBookName;
  final String giveBookName;

  OrderCreateTapped({required this.getBookName, required this.giveBookName});
}

final class OrderFindBookTapped extends OrderEvent {
  final String bookName;

  OrderFindBookTapped({required this.bookName});
}

final class OrderFoundBookTapped extends OrderEvent {
  final Book book;

  OrderFoundBookTapped({required this.book});
}
