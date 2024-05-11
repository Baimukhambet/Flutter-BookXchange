import 'dart:math';

import 'package:cubit_test/repositories/models/book.dart';
import 'package:cubit_test/repositories/services/library_api_service.dart';
import 'package:flutter/widgets.dart';

class LibraryRepository {
  final LibraryApiService libraryApiService = LibraryApiService.shared;

  static final shared = LibraryRepository._init();
  LibraryRepository._init();

  Future<List<Book>> findBooks(String query) async {
    final data = await libraryApiService.fetchBooks(query);
    // debugPrint(data.toString());
    final docs = data['docs'] as List<dynamic>;
    final List<Book> books = [];
    final int size = min(5, docs.length);
    debugPrint(docs.length.toString());
    for (var i = 0; i < min(5, size); i++) {
      final firstDoc = docs[i] as Map<String, dynamic>;
      final title = firstDoc['title'] as String;
      final imageUrl = (firstDoc['cover_i'] as int?).toString();
      books.add(Book(category: Category.all, name: title, imageUrl: imageUrl));
    }

    return books;
  }
}
