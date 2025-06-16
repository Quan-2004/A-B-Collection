import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookProvider extends ChangeNotifier {
  final BookService _bookService = BookService();
  
  List<Book> _featuredBooks = [];
  List<Book> _newestBooks = [];
  List<Book> _trendingBooks = [];
  bool _isLoading = false;
  String? _error;

  List<Book> get featuredBooks => _featuredBooks;
  List<Book> get newestBooks => _newestBooks;
  List<Book> get trendingBooks => _trendingBooks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadInitialData() async {
    debugPrint('Starting to load initial data...');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      debugPrint('Loading featured books...');
      _featuredBooks = await _bookService.getFeaturedBooks();
      debugPrint('Loaded ${_featuredBooks.length} featured books');

      debugPrint('Loading newest books...');
      _newestBooks = await _bookService.getNewestBooks();
      debugPrint('Loaded ${_newestBooks.length} newest books');

      debugPrint('Loading trending books...');
      _trendingBooks = await _bookService.getTrendingBooks();
      debugPrint('Loaded ${_trendingBooks.length} trending books');

    } catch (e) {
      debugPrint('Error loading books: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      debugPrint('Finished loading data. Notifying listeners...');
      notifyListeners();
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    try {
      return await _bookService.searchBooks(query);
    } catch (e) {
      debugPrint('Error searching books: $e');
      return [];
    }
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    try {
      return await _bookService.getBooksByCategory(category);
    } catch (e) {
      debugPrint('Error getting books by category: $e');
      return [];
    }
  }
}
