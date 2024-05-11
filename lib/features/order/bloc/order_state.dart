part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderFailed extends OrderState {}

final class OrderSuccess extends OrderState {}

final class OrderBooksLoading extends OrderState {}

final class OrderBooksLoaded extends OrderState {
  final List<Book> books;

  OrderBooksLoaded({required this.books});
}

final class OrderBooksFailure extends OrderState {
  String? message;
  OrderBooksFailure([this.message]);
}
