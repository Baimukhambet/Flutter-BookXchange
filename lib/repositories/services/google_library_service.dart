import 'dart:convert';

import 'package:cubit_test/repositories/services/abstract_library_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleLibraryService extends AbstractLibraryService {
  static final shared = GoogleLibraryService._init();
  final base_url = 'https://www.googleapis.com/books/v1/volumes';

  GoogleLibraryService._init();

  @override
  Future<Map<String, dynamic>> fetchBooks(String query) async {
    final url = Uri.parse(base_url).replace(queryParameters: {'q': query});
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
