part of 'order_bloc.dart';

class OrderState extends Equatable {
  final Book? giving;
  List<Book> taking;
  final List<Book> found_books;
  final bool hasError;
  final String errorMessage;
  final bool isLoading;

  OrderState({
    this.giving = null,
    this.taking = const [],
    this.hasError = false,
    this.errorMessage = '',
    this.isLoading = false,
    this.found_books = const [],
  });

  OrderState copyWith({
    Book? giving,
    List<Book>? taking,
    bool hasError = false,
    String errorMessage = '',
    bool isLoading = false,
    List<Book> found_books = const [],
  }) {
    return OrderState(
        giving: giving,
        taking: taking ?? this.taking,
        found_books: found_books,
        hasError: hasError,
        errorMessage: errorMessage,
        isLoading: isLoading);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [giving, taking, found_books, isLoading, hasError];
}
