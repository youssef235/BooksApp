import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/bookModel.dart';
import '../ViewModels/favoriteCubit.dart';
import '../Widgets/appBar.dart';
import '../Widgets/bottom_bar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().loadFavorites();

    return BlocBuilder<FavoritesCubit, List<Book>>(
      builder: (context, favorites) {
        return Scaffold(
          appBar: appBar().buildappBar(context, "Favorites"),
          body: favorites.isEmpty
              ? Center(child: Text("No favorite books added yet."))
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final book = favorites[index];
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
                                  book.authors ?? 'Unknown Author',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          // أيقونة القلب
                          IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(book);
                              context
                                  .read<FavoritesCubit>()
                                  .removeFromFavorites(book);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.favorite,
          ),
        );
      },
    );
  }
}
