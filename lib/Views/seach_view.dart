import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_me/Constants/apiKey.dart';
import 'package:read_me/ViewModels/booksCubit.dart';
import '../Repositories/book_repository .dart';
import '../ViewModels/booksState.dart';
import '../Widgets/appBar.dart';
import '../Widgets/bottom_bar.dart';
import '../Widgets/search_box.dart';
import 'book_detail_view .dart';
import 'categoies_view.dart';

class BooksSearchView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar().buildappBar(context, "Search"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Searchbox().buildSearchbox(context, _controller)),
            InkWell(
              onTap: () {
                final query = _controller.text;
                if (query.isNotEmpty) {
                  context.read<BookCubit>().searchBooks(query);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 50, left: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 236, 235, 235),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(child: Text('Click to Search')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                if (state is BookLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BookLoaded) {
                  return Column(
                    children: state.books.map((book) {
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.authors ?? 'No authors available'),
                        leading: book.thumbnail != null
                            ? Image.network(book.thumbnail!)
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailScreen(book: book),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                } else if (state is BookError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text(''));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.search,
      ),
    );
  }
}
