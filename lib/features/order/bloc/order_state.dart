part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderFailed extends OrderState {}

final class OrderSuccess extends OrderState {}
