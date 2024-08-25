import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_me/Constants/apiKey.dart';
import 'Repositories/book_repository .dart';
import 'ViewModels/booksCubit.dart';
import 'ViewModels/favoriteCubit.dart';
import 'Views/home_view.dart';
import 'Views/categoies_view.dart';
import 'Views/seach_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => BookCubit(BookRepositoryImpl(ApiKeys.apiKey))),
        BlocProvider(create: (context) => FavoritesCubit()..loadFavorites()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
