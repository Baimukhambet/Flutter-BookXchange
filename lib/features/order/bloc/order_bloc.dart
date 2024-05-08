import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../home/services/book_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final BookService bookService = BookService.shared;

  OrderBloc() : super(OrderInitial()) {
    on<OrderCreateTapped>(_createTapped);
  }

  Future<void> _createTapped(OrderCreateTapped event, Emitter emit) async {
    emit(OrderLoading());
    try {
      await bookService.addOrder(event.getBookName, event.giveBookName);
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailed());
    }
  }
}
