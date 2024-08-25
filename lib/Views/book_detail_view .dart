import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/bookModel.dart';
import '../ViewModels/favoriteCubit.dart';
import '../Widgets/appBar.dart';
import '../Widgets/bottom_bar.dart';
import 'book_reader_view.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar().buildappBar(context, book.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (book.thumbnail != null) Image.network(book.thumbnail!),
                BlocBuilder<FavoritesCubit, List<Book>>(
                  builder: (context, favorites) {
                    return IconButton(
                      icon: Icon(
                        favorites.any((favBook) => favBook.id == book.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favorites.any((favBook) => favBook.id == book.id)
                            ? Colors.red
                            : null,
                      ),
                      onPressed: () {
                        context.read<FavoritesCubit>().toggleFavorite(book);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Title: ${book.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Authors: ${book.authors ?? 'No authors available'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${book.description ?? 'No description available'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${book.category ?? 'No category available'}',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookReaderScreen(bookUrl: book.url),
                    ),
                  );
                },
                child: Text('Read Book'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: null,
      ),
    );
  }
}
