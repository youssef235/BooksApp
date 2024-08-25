import 'package:flutter/material.dart';

import '../Views/categoies_view.dart';

class CatBox {
  Widget catbox(BuildContext context, String category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BooksByCategoryScreen(category: category),
          ),
        );
      },
      child: Container(
        decoration: (const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 255, 158, 73))),
        margin: EdgeInsets.all(8),
        height: 40,
        width: 80,
        child: Center(
            child: Text(
          category,
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white),
        )),
      ),
    );
  }
}
