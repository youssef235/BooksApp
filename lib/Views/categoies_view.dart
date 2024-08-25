import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_me/ViewModels/booksCubit.dart';
import '../Constants/apiKey.dart';
import '../Models/bookModel.dart';
import '../Repositories/book_repository .dart';
import '../ViewModels/booksState.dart';
import '../Widgets/appBar.dart';
import '../Widgets/bottom_bar.dart';
import 'book_detail_view .dart';

class BooksByCategoryScreen extends StatelessWidget {
  final String category;

  BooksByCategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit(BookRepositoryImpl(ApiKeys.apiKey))
        ..getBooksByCategory(category),
      child: Scaffold(
        appBar: appBar().buildappBar(context, 'Books in $category'),
        body: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            if (state is BookLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookLoaded) {
              return ListView(
                children: state.books.map((book) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(8.0), // إضافة مسافة داخلية
                    title: Row(
                      children: [
                        // صورة الكتاب
                        book.thumbnail != null
                            ? Container(
                                width: 80, // عرض الصورة
                                height: 120, // ارتفاع الصورة
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(book.thumbnail!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 80,
                                height: 120), // مساحة فارغة إذا لم توجد صورة
                        SizedBox(width: 10), // مسافة بين الصورة والعنوان
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                book.authors ?? 'No authors available',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            } else if (state is BookError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No books available'));
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: null,
        ),
      ),
    );
  }
}
