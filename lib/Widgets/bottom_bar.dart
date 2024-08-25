import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/bookModel.dart';
import '../Repositories/book_repository .dart';
import '../ViewModels/favoriteCubit.dart';
import '../Views/favorite_books_view.dart';
import '../Views/home_view.dart';
import '../Views/seach_view.dart';

enum MenuState { home, favorite, search }

class CustomBottomNavBar extends StatelessWidget {
  final MenuState? selectedMenu;
  final List<Book>? allBooks;
  final List<Book>? favBooks;

  CustomBottomNavBar({
    Key? key,
    this.selectedMenu,
    this.allBooks,
    this.favBooks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color inactiveIconColor = Color(0xFFB6B6B6);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: MenuState.home == selectedMenu
                  ? Color.fromARGB(255, 255, 158, 73)
                  : inactiveIconColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              color: MenuState.favorite == selectedMenu
                  ? Color.fromARGB(255, 255, 158, 73)
                  : inactiveIconColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => FavoritesCubit()..loadFavorites(),
                      child: FavoritesScreen(), // استخدام favBooks هنا
                    );
                  }),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              color: MenuState.search == selectedMenu
                  ? Color.fromARGB(255, 255, 158, 73)
                  : inactiveIconColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BooksSearchView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
