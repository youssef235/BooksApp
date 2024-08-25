import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/bookModel.dart';

class FavoritesCubit extends Cubit<List<Book>> {
  FavoritesCubit() : super([]);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');

    if (favoritesJson != null) {
      List<dynamic> favoritesList = json.decode(favoritesJson);
      List<Book> favorites =
          favoritesList.map((book) => Book.fromJson(book)).toList();
      emit(favorites);
    } else {
      emit([]);
    }
  }

  Future<void> toggleFavorite(Book book) async {
    final currentFavorites = List<Book>.from(state);

    if (currentFavorites.any((favBook) => favBook.id == book.id)) {
      currentFavorites.removeWhere((favBook) => favBook.id == book.id);
    } else {
      currentFavorites.add(book);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites',
        json.encode(currentFavorites.map((b) => b.toJson()).toList()));
    emit(currentFavorites);
  }

  Future<void> removeFromFavorites(Book book) async {
    final currentFavorites = List<Book>.from(state);
    currentFavorites.removeWhere((favBook) => favBook.id == book.id);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites',
        json.encode(currentFavorites.map((b) => b.toJson()).toList()));
    emit(currentFavorites);
  }
}
