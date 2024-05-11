import 'dart:math';

import 'package:cubit_test/repositories/models/book.dart';
import 'package:cubit_test/repositories/services/google_library_service.dart';
import 'package:cubit_test/repositories/services/library_api_service.dart';
import 'package:flutter/widgets.dart';

class GoogleLibraryRepository {
  final GoogleLibraryService libraryApiService = GoogleLibraryService.shared;

  static final shared = GoogleLibraryRepository._init();
  GoogleLibraryRepository._init();

  Future<List<Book>> findBooks(String query) async {
    final data = await libraryApiService.fetchBooks(query);
    final docs = data['items'] as List<dynamic>;
    final List<Book> books = [];
    final int size = min(10, docs.length);
    debugPrint(docs.length.toString());
    for (var i = 0; i < size; i++) {
      final doc = docs[i] as Map<String, dynamic>;
      final volumeInfo = doc['volumeInfo'] as Map<String, dynamic>;
      debugPrint(volumeInfo.toString());
      final title = volumeInfo['title'];
      if (!volumeInfo.containsKey('imageLinks')) {
        continue;
      }
      final imageUrl = volumeInfo.containsKey('imageLinks')
          ? (volumeInfo['imageLinks'] as Map<String, dynamic>)['thumbnail']
          : '';
      debugPrint(imageUrl);
      books.add(Book(category: Category.all, name: title, imageUrl: imageUrl));
    }

    return books;
  }
}
//гарри поттер