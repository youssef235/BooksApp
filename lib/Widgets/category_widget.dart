import 'package:flutter/material.dart';
import 'categoryBox.dart';

class CategoryWidget {
  Widget buildCategory(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CatBox().catbox(context, "Fiction"),
            CatBox().catbox(context, "Science"),
            CatBox().catbox(context, "History"),
            CatBox().catbox(context, "Biography"),
            CatBox().catbox(context, "Technology"),
          ],
        ),
      ),
    );
  }
}
