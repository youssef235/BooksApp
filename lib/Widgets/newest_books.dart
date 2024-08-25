import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/apiKey.dart';
import '../Repositories/book_repository .dart';
import '../ViewModels/booksCubit.dart';
import '../ViewModels/booksState.dart';
import '../Views/book_detail_view .dart';

class NewestBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) =>
          BookCubit(BookRepositoryImpl(ApiKeys.apiKey))..getNewestBooks(),
      child: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          } else if (state is BookLoaded) {
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(book.thumbnail ?? '',
                                fit: BoxFit.cover),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            book.title,
                            style: textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return SizedBox(); // Empty container for initial state
        },
      ),
    );
  }
}
