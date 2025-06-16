import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookService {
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> searchBooks(String query) async {
    debugPrint('Calling API with query: $query');
    final url = '$baseUrl?q=$query&maxResults=40';
    debugPrint('URL: $url');

    try {
      final response = await http.get(Uri.parse(url));
      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body.substring(0, 200)}...'); // Show first 200 chars

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List?;
        
        if (items == null) {
          debugPrint('No items found in response');
          return [];
        }

        debugPrint('Found ${items.length} books');
        final books = items.map((item) => Book.fromJson(item)).toList();
        debugPrint('First book title: ${books.first.title}');
        return books;
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in searchBooks: $e');
      rethrow;
    }
  }

  Future<List<Book>> getFeaturedBooks() async {
    debugPrint('Getting featured books...');
    return searchBooks('subject:fiction+orderBy=relevance');
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    debugPrint('Getting books for category: $category');
    return searchBooks('subject:$category');
  }

  Future<List<Book>> getNewestBooks() async {
    debugPrint('Getting newest books...');
    return searchBooks('orderBy=newest');
  }

  Future<List<Book>> getTrendingBooks() async {
    debugPrint('Getting trending books...');
    return searchBooks('orderBy=relevance');
  }
}
