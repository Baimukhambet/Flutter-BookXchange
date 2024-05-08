part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderCreateTapped extends OrderEvent {
  final String getBookName;
  final String giveBookName;

  OrderCreateTapped({required this.getBookName, required this.giveBookName});
}
