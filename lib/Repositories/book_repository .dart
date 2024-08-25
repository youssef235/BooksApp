import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/bookModel.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query);
  Future<List<Book>> getBooksByCategory(String category);
  Future<List<Book>> getTrendingBooks();
  Future<List<Book>> getNewestBooks();
  Future<List<Book>> getBestSellerBooks();
}

class BookRepositoryImpl implements BookRepository {
  final String apiKey;
  List<Book> _allBooks = [];

  BookRepositoryImpl(this.apiKey);

  @override
  Future<List<Book>> searchBooks(String query) async {
    return _fetchBooks(
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey');
  }

  @override
  Future<List<Book>> getBooksByCategory(String category) async {
    return _fetchBooks(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$category&key=$apiKey');
  }

  @override
  Future<List<Book>> getTrendingBooks() async {
    return _fetchBooks(
        'https://www.googleapis.com/books/v1/volumes?q=subject:fiction&orderBy=newest&key=$apiKey');
  }

  @override
  Future<List<Book>> getNewestBooks() async {
    return _fetchBooks(
        'https://www.googleapis.com/books/v1/volumes?q=new&orderBy=newest&key=$apiKey');
  }

  @override
  Future<List<Book>> getBestSellerBooks() async {
    return _fetchBooks(
        'https://www.googleapis.com/books/v1/volumes?q=bestseller&orderBy=relevance&key=$apiKey');
  }

  Future<List<Book>> _fetchBooks(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'] == null) {
        throw Exception('No books found');
      }
      return (data['items'] as List<dynamic>)
          .map((json) => Book.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Failed to load books; Status code: ${response.statusCode}');
    }
  }

  Future<List<Book>> getAllBooks() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.googleapis.com/books/v1/volumes'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['items'] == null) {
          throw Exception('No books found');
        }
        return (data['items'] as List<dynamic>)
            .map((json) => Book.fromJson(json))
            .toList();
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      print(' $e');
      return [];
    }
  }
}
