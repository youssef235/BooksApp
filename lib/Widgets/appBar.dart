import 'package:flutter/material.dart';

class appBar {
  PreferredSizeWidget? buildappBar(BuildContext context, String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
