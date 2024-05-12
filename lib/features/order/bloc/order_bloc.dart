import 'package:cubit_test/repositories/google_library_repository.dart';
import 'package:cubit_test/repositories/library_repository.dart';
import 'package:cubit_test/repositories/models/book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../home/services/book_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final BookService bookService = BookService.shared;
  final GoogleLibraryRepository libraryRepository =
      GoogleLibraryRepository.shared;

  OrderBloc() : super(OrderForm()) {
    on<OrderCreateTapped>(_createTapped);
    on<OrderFindBookTapped>(_findBookTapped);
    on<OrderFoundBookTapped>(_foundBookTapped);
    on<OrderCancelBookTapped>(_cancelBookTapped);
    on<OrderGetBookChosen>(_getBookChosen);
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
    if (event.bookName.isEmpty) {
      emit(OrderBooksFailure('Ничего не найдено'));
      return;
    }
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

  void _cancelBookTapped(OrderCancelBookTapped event, Emitter emit) {
    emit(OrderInitial());
  }

  void _getBookChosen(OrderGetBookChosen event, Emitter emit) {
    if (event.book != null) {
      debugPrint("We did it!");
      if (state is OrderForm) {
        final oldState = state as OrderForm;
        OrderForm newState = OrderForm(oldState.giving);
        newState.taking = oldState.taking;
        newState.taking.add(event.book!);

        debugPrint((state == newState).toString());
        emit(newState);
        return;
      }
      final newForm = OrderForm();
      newForm.taking.add(event.book!);
      debugPrint(newForm.taking.toString());
      emit(newForm);
    }
  }
}
