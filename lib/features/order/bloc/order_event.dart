part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderCreateTapped extends OrderEvent {}

final class OrderFindBookTapped extends OrderEvent {
  final String bookName;

  OrderFindBookTapped({required this.bookName});
}

final class OrderFoundBookTapped extends OrderEvent {
  final Book book;

  OrderFoundBookTapped({required this.book});
}

final class OrderGetBookChosen extends OrderEvent {
  Book? book;
  OrderGetBookChosen({this.book});
}

final class OrderCancelBookTapped extends OrderEvent {}

final class OrderReset extends OrderEvent {}
