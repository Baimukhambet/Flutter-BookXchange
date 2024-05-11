import 'dart:convert';

import 'package:cubit_test/repositories/services/abstract_library_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LibraryApiService extends AbstractLibraryService {
  static final shared = LibraryApiService._init();
  final base_url = 'https://openlibrary.org/search.json';

  LibraryApiService._init();

  @override
  Future<Map<String, dynamic>> fetchBooks(String query) async {
    final url = Uri.parse(base_url)
        .replace(queryParameters: {'q': query, 'lang': 'ru'});
    debugPrint(url.toString());
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // debugPrint(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed fetching');
    }
  }
}
