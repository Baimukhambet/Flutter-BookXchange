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

  OrderBloc() : super(OrderState()) {
    on<OrderCreateTapped>(_createTapped);
    on<OrderFindBookTapped>(_findBookTapped);
    on<OrderFoundBookTapped>(_foundBookTapped);
    on<OrderCancelBookTapped>(_cancelBookTapped);
    on<OrderGetBookChosen>(_getBookChosen);
    on<OrderReset>(_orderReset);
  }

  Future<void> _createTapped(OrderCreateTapped event, Emitter emit) async {
    emit(state.copyWith(isCreatingOrder: true, giving: state.giving));
    try {
      debugPrint(state.giving.toString() + '+' + state.taking.toString());
      await bookService.addOrder(state.giving!, state.taking!);
      emit(state.copyWith(orderIsCreated: true));
    } catch (e) {
      emit(state.copyWith(hasError: true, errorMessage: e.toString()));
    }
  }

  void _findBookTapped(OrderFindBookTapped event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    if (event.bookName.isEmpty) {
      emit(state.copyWith());
      return;
    }
    try {
      final foundBooks = await libraryRepository.findBooks(event.bookName);
      emit(state.copyWith(found_books: foundBooks));
    } catch (e) {
      emit(state.copyWith(hasError: true, errorMessage: e.toString()));
    }
  }

  void _foundBookTapped(OrderFoundBookTapped event, Emitter emit) {
    emit(state.copyWith(giving: event.book));
  }

  void _cancelBookTapped(OrderCancelBookTapped event, Emitter emit) {
    emit(state.copyWith(giving: null));
  }

  void _getBookChosen(OrderGetBookChosen event, Emitter emit) {
    if (event.book != null) {
      List<Book> taking = [...state.taking];
      taking.add(event.book!);
      emit(state.copyWith(taking: taking, giving: state.giving));
    }
  }

  void _orderReset(OrderReset event, Emitter emit) {
    emit(OrderState());
  }
}
