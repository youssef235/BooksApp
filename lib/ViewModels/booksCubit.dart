import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/bookModel.dart';
import '../Repositories/book_repository .dart';
import 'booksState.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;

  BookCubit(this.bookRepository) : super(BookInitial());

  Future<void> searchBooks(String query) async {
    emit(BookLoading());

    try {
      final books = await bookRepository.searchBooks(query);
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> getBooksByCategory(String category) async {
    emit(BookLoading());

    try {
      final books = await bookRepository.getBooksByCategory(category);
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> getTrendingBooks() async {
    emit(BookLoading());

    try {
      final books = await bookRepository.getTrendingBooks();
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> getNewestBooks() async {
    emit(BookLoading());

    try {
      final books = await bookRepository.getNewestBooks();
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

  Future<void> getBestSellerBooks() async {
    emit(BookLoading());

    try {
      final books = await bookRepository.getBestSellerBooks();
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
