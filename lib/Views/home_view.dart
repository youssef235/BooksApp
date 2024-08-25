import 'package:flutter/material.dart';
import 'package:read_me/Views/seach_view.dart';
import '../Constants/apiKey.dart';
import '../Repositories/book_repository .dart';
import '../Widgets/appBar.dart';
import '../Widgets/best_Seller.dart';
import '../Widgets/books_Section_box.dart';
import '../Widgets/bottom_bar.dart';
import '../Widgets/category_widget.dart';
import '../Widgets/newest_books.dart';
import '../Widgets/trending_books.dart';
import 'book_detail_view .dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../ViewModels/booksCubit.dart';
import '../ViewModels/booksState.dart';
import '../Models/bookModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookCubit(BookRepositoryImpl(ApiKeys.apiKey))..getTrendingBooks(),
      child: Scaffold(
        appBar: appBar().buildappBar(context, "Home"),
        body: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryWidget().buildCategory(context),
                      SectinBox().sectinBox(context, "Trending Books"),
                      TrendingBooks().build(context),
                      SectinBox().sectinBox(context, "Best seller Books"),
                      BestSellerBooks().build(context),
                      SectinBox().sectinBox(context, "Newest Books"),
                      NewestBooks().build(context),
                    ],
                  ),
                ),
              );
            } else if (state is BookError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No books available'));
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.home,
        ),
      ),
    );
  }
}
