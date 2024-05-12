import 'package:cubit_test/repositories/google_library_repository.dart';
import 'package:cubit_test/repositories/library_repository.dart';
import 'package:cubit_test/repositories/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../home/services/book_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final BookService bookService = BookService.shared;
  final GoogleLibraryRepository libraryRepository =
      GoogleLibraryRepository.shared;

  OrderBloc() : super(OrderInitial()) {
    on<OrderCreateTapped>(_createTapped);
    on<OrderFindBookTapped>(_findBookTapped);
    on<OrderFoundBookTapped>(_foundBookTapped);
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

  void _findBookTapped(OrderFindBookTapped event, Emitter emit) async {
    emit(OrderBooksLoading());
    try {
      final books = await libraryRepository.findBooks(event.bookName);
      emit(OrderBooksLoaded(books: books));
    } catch (e) {
      emit(OrderBooksFailure(e.toString()));
    }
  }

  void _foundBookTapped(OrderFoundBookTapped event, Emitter emit) {
    emit(OrderForm(event.book));
  }
}
